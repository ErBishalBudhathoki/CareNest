const { createLogger } = require('./logger');

// Simple in-memory API usage monitor with SSE support
class ApiUsageMonitor {
  constructor() {
    this.logger = createLogger('ApiUsageMonitor');

    // Configuration
    this.HISTORY_SIZE = parseInt(process.env.API_USAGE_HISTORY_SIZE || '1000', 10);
    this.ENDPOINT_LIMIT = parseInt(process.env.API_USAGE_ENDPOINT_LIMIT || '5000', 10);

    // State
    this.totalRequests = 0;
    this.statusBuckets = { '2xx': 0, '3xx': 0, '4xx': 0, '5xx': 0 };
    this.requestTimestamps = []; // for RPM/TPM calculations (store last 10 minutes)
    this.history = []; // ring buffer of last N requests
    this.endpoints = new Map(); // key: METHOD path -> stats
    // Store SSE clients with metadata so we can surface active connections list
    this.clients = new Map(); // key: res -> { ip, userId, email, connectedAt, requests }
    this.ipStats = new Map(); // key: ip -> stats
    this.userStats = new Map(); // key: userId -> stats
  }

  middleware = (req, res, next) => {
    const startNs = process.hrtime.bigint();
    const method = (req.method || 'GET').toUpperCase();
    const path = (req.originalUrl || req.url || '').split('?')[0] || '/';
    const ip = req.ip || (req.connection && req.connection.remoteAddress) || 'unknown';

    res.on('finish', () => {
      try {
        const durationMs = Number(process.hrtime.bigint() - startNs) / 1e6;
        const status = res.statusCode || 0;
        const userId = req.user && (req.user.id || req.user.userId || req.user.uid)
          ? (req.user.id || req.user.userId || req.user.uid)
          : null;
        const userEmail = req.user && req.user.email ? req.user.email : null;
        this.record({ method, path, status, durationMs, ip, userId, userEmail });
      } catch (e) {
        this.logger.warn('Failed to record API usage on finish', { error: e.message });
      }
    });

    next();
  };

  record({ method, path, status, durationMs, ip, userId, userEmail }) {
    const now = Date.now();
    this.totalRequests += 1;

    // Status buckets
    const bucket = status >= 500 ? '5xx' : status >= 400 ? '4xx' : status >= 300 ? '3xx' : '2xx';
    this.statusBuckets[bucket] += 1;

    // Request timestamps: keep last 10 minutes
    this.requestTimestamps.push(now);
    const cutoff = now - 10 * 60 * 1000;
    while (this.requestTimestamps.length && this.requestTimestamps[0] < cutoff) {
      this.requestTimestamps.shift();
    }

    // History ring buffer
    const item = { ts: new Date(now).toISOString(), method, path, status, durationMs, ip, userId, userEmail };
    this.history.push(item);
    if (this.history.length > this.HISTORY_SIZE) {
      this.history.shift();
    }

    // Endpoint stats
    const key = `${method} ${path}`;
    let ep = this.endpoints.get(key);
    if (!ep) {
      ep = { key, method, path, count: 0, status: { '2xx': 0, '3xx': 0, '4xx': 0, '5xx': 0 }, totalDuration: 0, lastSeen: now };
      if (this.endpoints.size < this.ENDPOINT_LIMIT) {
        this.endpoints.set(key, ep);
      }
    }
    if (ep) {
      ep.count += 1;
      ep.status[bucket] += 1;
      ep.totalDuration += durationMs || 0;
      ep.lastSeen = now;
    }

    // IP stats
    if (ip) {
      let ipS = this.ipStats.get(ip);
      if (!ipS) {
        ipS = { ip, count: 0, status: { '2xx': 0, '3xx': 0, '4xx': 0, '5xx': 0 }, totalDuration: 0, lastSeen: now };
        this.ipStats.set(ip, ipS);
      }
      ipS.count += 1;
      ipS.status[bucket] += 1;
      ipS.totalDuration += durationMs || 0;
      ipS.lastSeen = now;
    }

    // User stats
    if (userId) {
      let uS = this.userStats.get(userId);
      if (!uS) {
        uS = { userId, userEmail, count: 0, status: { '2xx': 0, '3xx': 0, '4xx': 0, '5xx': 0 }, totalDuration: 0, lastSeen: now };
        this.userStats.set(userId, uS);
      }
      // Update email if it wasn't previously stored or if it's different
      if (userEmail && (!uS.userEmail || uS.userEmail !== userEmail)) {
        uS.userEmail = userEmail;
      }
      uS.count += 1;
      uS.status[bucket] += 1;
      uS.totalDuration += durationMs || 0;
      uS.lastSeen = now;
    }

    // Broadcast to SSE clients (lightweight update)
    this.broadcast({
      type: 'request',
      at: item.ts,
      method,
      path,
      status,
      durationMs,
      ip,
      userId,
      userEmail,
      totals: { totalRequests: this.totalRequests, buckets: this.statusBuckets },
    });
  }

  getSummary() {
    const now = Date.now();
    const oneMinute = now - 60 * 1000;
    const fiveMinutes = now - 5 * 60 * 1000;

    const last1m = this.requestTimestamps.filter(t => t >= oneMinute).length;
    const last5m = this.requestTimestamps.filter(t => t >= fiveMinutes).length;

    // Top endpoints by count
    const endpointsArr = Array.from(this.endpoints.values());
    const topEndpoints = endpointsArr
      .sort((a, b) => b.count - a.count)
      .slice(0, 10)
      .map(e => ({
        key: e.key,
        count: e.count,
        avgLatencyMs: e.count ? +(e.totalDuration / e.count).toFixed(2) : 0,
        status: e.status,
        lastSeen: new Date(e.lastSeen).toISOString()
      }));

    const avgLatency = (() => {
      const totalDuration = endpointsArr.reduce((sum, e) => sum + e.totalDuration, 0);
      const totalCount = endpointsArr.reduce((sum, e) => sum + e.count, 0);
      return totalCount ? +(totalDuration / totalCount).toFixed(2) : 0;
    })();

    return {
      totalRequests: this.totalRequests,
      statusBuckets: this.statusBuckets,
      requestsLast1m: last1m,
      requestsLast5m: last5m,
      uniqueEndpoints: endpointsArr.length,
      avgLatencyMs: avgLatency,
      topEndpoints,
      activeSSEClients: this.clients.size,
      lastUpdated: new Date().toISOString()
    };
  }

  getHistory(limit = 100) {
    const n = Math.max(1, Math.min(limit, this.HISTORY_SIZE));
    const start = Math.max(0, this.history.length - n);
    return this.history.slice(start).reverse(); // newest first
  }

  getEndpoints() {
    return Array.from(this.endpoints.values()).map(e => ({
      key: e.key,
      method: e.method,
      path: e.path,
      count: e.count,
      avgLatencyMs: e.count ? +(e.totalDuration / e.count).toFixed(2) : 0,
      status: e.status,
      lastSeen: new Date(e.lastSeen).toISOString()
    }));
  }

  getTopIPs(top = 50) {
    const arr = Array.from(this.ipStats.values()).map(s => ({
      ip: s.ip,
      count: s.count,
      status: s.status,
      avgLatencyMs: s.count ? +(s.totalDuration / s.count).toFixed(2) : 0,
      errorRate: s.count ? +(((s.status['4xx'] + s.status['5xx']) / s.count) * 100).toFixed(2) : 0,
      lastSeen: new Date(s.lastSeen).toISOString()
    }));
    return arr.sort((a, b) => b.count - a.count).slice(0, Math.max(1, Math.min(top, 500)));
  }

  getTopUsers(top = 50) {
    const arr = Array.from(this.userStats.values()).map(s => ({
      userId: s.userId,
      userEmail: s.userEmail,
      count: s.count,
      status: s.status,
      avgLatencyMs: s.count ? +(s.totalDuration / s.count).toFixed(2) : 0,
      errorRate: s.count ? +(((s.status['4xx'] + s.status['5xx']) / s.count) * 100).toFixed(2) : 0,
      lastSeen: new Date(s.lastSeen).toISOString()
    }));
    return arr.sort((a, b) => b.count - a.count).slice(0, Math.max(1, Math.min(top, 500)));
  }

  // Return structured list of active SSE connections with basic metadata
  getActiveConnections() {
    return Array.from(this.clients.values()).map(info => ({
      ip: info.ip || null,
      userId: info.userId || null,
      email: info.email || null,
      connectedAt: info.connectedAt,
      requests: info.requests || 0,
    }));
  }

  reset(userId = null) {
    if (userId) {
      // Reset only for specific user
      if (this.userStats.has(userId)) {
        // Get current stats for the user
        const userStats = this.userStats.get(userId);
        
        // Remove user's contribution from total counts
        this.totalRequests -= userStats.count;
        this.statusBuckets['2xx'] -= userStats.status['2xx'] || 0;
        this.statusBuckets['3xx'] -= userStats.status['3xx'] || 0;
        this.statusBuckets['4xx'] -= userStats.status['4xx'] || 0;
        this.statusBuckets['5xx'] -= userStats.status['5xx'] || 0;
        
        // Remove user from history
        this.history = this.history.filter(item => item.userId !== userId);
        
        // Reset user stats
        this.userStats.delete(userId);
        
        // Notify SSE clients
        this.broadcast({ 
          type: 'user-reset', 
          userId: userId,
          at: new Date().toISOString() 
        });
        
        return true;
      }
      return false;
    } else {
      // Reset all stats
      this.totalRequests = 0;
      this.statusBuckets = { '2xx': 0, '3xx': 0, '4xx': 0, '5xx': 0 };
      this.requestTimestamps = [];
      this.history = [];
      this.endpoints.clear();
      this.ipStats.clear();
      this.userStats.clear();
      // Notify SSE clients
      this.broadcast({ type: 'reset', at: new Date().toISOString() });
      return true;
    }
  }

  addSSEClient(res, meta = {}) {
    // Keep connection open by sending a heartbeat every 20s
    const heartBeat = setInterval(() => {
      try {
        res.write(`event: ping\n`);
        res.write(`data: {"t":"${new Date().toISOString()}"}\n\n`);
      } catch (_) {
        // ignore
      }
    }, 20000);

    // Store client with metadata
    this.clients.set(res, {
      ip: meta.ip || null,
      userId: meta.userId || null,
      email: meta.email || null,
      connectedAt: new Date().toISOString(),
      requests: 0,
    });

    const cleanup = () => {
      clearInterval(heartBeat);
      this.clients.delete(res);
      try {
        res.end();
      } catch (_) {}
    };

    return cleanup;
  }

  broadcast(payload) {
    if (!this.clients.size) return;

    // If this is a request event, opportunistically increment request counts for matching clients
    if (payload && payload.type === 'request') {
      for (const [, info] of this.clients) {
        if ((payload.userId && info.userId && payload.userId === info.userId) ||
            (payload.ip && info.ip && payload.ip === info.ip)) {
          info.requests = (info.requests || 0) + 1;
        }
      }
    }

    const data = `data: ${JSON.stringify(payload)}\n\n`;
    for (const res of this.clients.keys()) {
      try {
        res.write(data);
      } catch (e) {
        // Drop broken client
        try { res.end(); } catch (_) {}
        this.clients.delete(res);
      }
    }
  }
}

const apiUsageMonitor = new ApiUsageMonitor();

module.exports = { apiUsageMonitor };