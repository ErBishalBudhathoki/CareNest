import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carenest/config/environment.dart';
import 'package:carenest/app/shared/design_system/modern_saas_design_system.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';

class ApiUsageDashboardView extends StatefulWidget {
  const ApiUsageDashboardView({super.key});

  @override
  State<ApiUsageDashboardView> createState() => _ApiUsageDashboardViewState();
}

class _ApiUsageDashboardViewState extends State<ApiUsageDashboardView> {
  final ApiMethod _api = ApiMethod();
  Map<String, dynamic>? _analyticsData;
  Map<String, dynamic>? _realTimeData;
  Map<String, dynamic>? _rateLimitConfig;
  List<dynamic> _blockedIPs = [];
  List<dynamic> _failedAttempts = [];
  List<dynamic> _activeConnections = [];
  String? _error;
  bool _loading = true;
  bool _realTimeLoading = false;

  // Live SSE
  final List<Map<String, dynamic>> _liveEvents = [];
  StreamSubscription<String>? _sseSub;
  http.Client? _sseClient;

  // Organization ID for API calls
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _getOrganizationId().then((_) async {
      // Establish SSE first so analytics can include this connection
      _connectSSE();
      // Give the server a brief moment to register this SSE client
      await Future.delayed(const Duration(milliseconds: 300));
      _loadAll();
    });
  }

  @override
  void dispose() {
    _sseSub?.cancel();
    _sseClient?.close();
    super.dispose();
  }

  Future<void> _getOrganizationId() async {
    final sharedUtils = SharedPreferencesUtils();
    await sharedUtils.init();
    _organizationId = sharedUtils.getString('organizationId');
  }

  Future<void> _loadAll() async {
    if (_organizationId == null) {
      setState(() {
        _error = 'Organization ID not available';
        _loading = false;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final futures = [
        _api.get('api/analytics/api-usage/$_organizationId'),
        _api.get('api/analytics/api-usage/rate-limits'),
        _api.get('api/analytics/api-usage/realtime/$_organizationId'),
      ];

      // Try to fetch admin rate limit status (optional: requires admin privileges)
      // If unauthorized, we just ignore the result and rely on analytics payload.
      futures.add(
        _api.get('api/security/rate-limit/status').catchError((_) => null),
      );

      final results = await Future.wait(futures);

      // Check for errors among the first three critical calls
      String? firstError;
      for (int i = 0; i < 3; i++) {
        final r = results[i];
        if (r is Map && r['success'] == false) {
          firstError =
              (r['message'] ?? r['error'] ?? 'Request failed').toString();
          break;
        }
      }

      if (firstError != null) {
        setState(() {
          _error = firstError;
          _analyticsData = null;
          _rateLimitConfig = null;
          _realTimeData = null;
          _loading = false;
        });
        return;
      }

      setState(() {
        final analyticsResult = results[0] as Map<String, dynamic>;
        final rateLimitResult = results[1] as Map<String, dynamic>;
        final realTimeResult = results[2] as Map<String, dynamic>;
        final statusResult = results.length > 3 ? results[3] : null;

        _analyticsData = analyticsResult['data'] ?? {};
        _rateLimitConfig = rateLimitResult['data'] ?? {};
        _realTimeData = realTimeResult['data'] ?? {};

        // Extract security data from analytics by default
        _blockedIPs = _analyticsData?['security']?['blockedIPs'] ?? [];
        _failedAttempts = _analyticsData?['security']?['failedAttempts'] ?? [];

        // If admin status endpoint succeeded, prefer its data
        if (statusResult is Map) {
          final Map statusMap = statusResult as Map;
          if (statusMap['success'] == true) {
            final statusData = statusMap['data'] as Map<String, dynamic>?;
            if (statusData != null) {
              _blockedIPs = (statusData['blockedIPs'] as List?) ?? _blockedIPs;
              _failedAttempts =
                  (statusData['failedAttempts'] as List?) ?? _failedAttempts;
            }
          }
        }

        // Also update active connections from analytics/realtime
        _activeConnections =
            _analyticsData?['security']?['activeConnections'] ?? [];

        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load API usage data: $e';
        _loading = false;
      });
    }
  }

  void _connectSSE() async {
    if (_organizationId == null) {
      debugPrint(
          '[SSE] Organization ID not available, skipping SSE connection');
      return;
    }

    try {
      _sseClient = http.Client();
      final base = _api.baseUrl;
      final cleanBase =
          base.endsWith('/') ? base.substring(0, base.length - 1) : base;
      final uri = Uri.parse(
          '$cleanBase/api/analytics/api-usage/stream/$_organizationId');
      debugPrint('[SSE] Attempting connection to: $uri');
      debugPrint('[SSE] Base URL: $base');

      // Attach auth token for protected SSE endpoint
      final sharedUtils = SharedPreferencesUtils();
      await sharedUtils.init();
      final token = sharedUtils.getAuthToken();
      final hasToken = token != null && token.isNotEmpty;
      final tokenHasBearer =
          hasToken && token!.toLowerCase().startsWith('bearer ');
      debugPrint('[SSE] Auth token present: $hasToken');

      final req = http.Request('GET', uri);
      final String? authValue = hasToken
          ? (token!.toLowerCase().startsWith('bearer ')
              ? token
              : 'Bearer $token')
          : null;
      req.headers.addAll({
        'Accept': 'text/event-stream',
        'Cache-Control': 'no-cache',
        if (authValue != null) 'Authorization': authValue,
      });

      final resp = await _sseClient!.send(req);
      debugPrint('[SSE] Response status: ${resp.statusCode}');
      if (resp.statusCode != 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Live stream unavailable (${resp.statusCode})')),
          );
        }
        return;
      }

      // Transform to lines and parse SSE events
      final stream =
          resp.stream.transform(utf8.decoder).transform(const LineSplitter());
      String buffer = '';
      _sseSub = stream.listen((line) {
        if (line.isEmpty) {
          // end of event
          if (buffer.isNotEmpty) {
            try {
              final dataIndex = buffer.indexOf('data:');
              if (dataIndex != -1) {
                final payload = buffer.substring(dataIndex + 5).trim();
                final jsonStart = payload.indexOf('{');
                final jsonStr =
                    jsonStart == -1 ? payload : payload.substring(jsonStart);
                final decoded = json.decode(jsonStr);
                // Only record actual request events; ignore ping/ready and other misc events
                if (decoded is Map<String, dynamic> &&
                    decoded['type'] == 'request') {
                  setState(() {
                    _liveEvents.insert(0, decoded);
                    if (_liveEvents.length > 100) {
                      _liveEvents.removeLast();
                    }
                  });
                }
              }
            } catch (e) {
              debugPrint('[SSE] Parse error: $e');
            }
            buffer = '';
          }
        } else if (line.startsWith('data:')) {
          buffer += (buffer.isEmpty ? '' : '\n') + line;
        }
      }, onError: (err) {
        debugPrint('[SSE] Stream error: $err');
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Live stream disconnected')),
        );
      }, onDone: () {
        debugPrint('[SSE] Stream closed by server');
        // Retry after 5 seconds if still mounted
        if (mounted) {
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted) _connectSSE();
          });
        }
      });
    } catch (e) {
      debugPrint('[SSE] Exception: $e');
      // Retry after 5 seconds if still mounted
      if (mounted) {
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) _connectSSE();
        });
      }
    }
  }

  Future<void> _unblockIpAddress(String ipAddress) async {
    try {
      final res = await _api.post('api/analytics/api-usage/unblock-ip',
          body: {'ipAddress': ipAddress});

      if (!mounted) return;

      if (res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('IP address $ipAddress unblocked successfully')),
        );
        _loadAll(); // Reload data to reflect changes
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to unblock IP: ${res['message'] ?? 'Unknown error'}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error unblocking IP: $e')),
      );
    }
  }

  Future<void> _resetRateLimitForIp(String ip) async {
    try {
      final res = await _api.post('api/security/rate-limit/reset', body: {
        'ip': ip,
      });

      if (!mounted) return;

      if (res is Map && res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rate limit reset for $ip')),
        );
        _loadAll();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to reset rate limit: ${res is Map ? (res['message'] ?? 'Unknown error') : 'Unknown error'}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resetting rate limit: $e')),
      );
    }
  }

  Future<void> _refreshRealTimeData() async {
    if (_organizationId == null) return;

    setState(() {
      _realTimeLoading = true;
    });

    try {
      final result =
          await _api.get('api/analytics/api-usage/realtime/$_organizationId');

      if (result['success'] == true) {
        setState(() {
          _realTimeData = result['data'] ?? {};
          // Also update active connections from real-time endpoint if available
          final ac = _realTimeData?['activeConnections'];
          if (ac is List) {
            _activeConnections = ac;
          }
          _realTimeLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _realTimeLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Usage Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Refresh real-time data',
            onPressed: _refreshRealTimeData,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Reload all data',
            onPressed: _loadAll,
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : RefreshIndicator(
                  onRefresh: _loadAll,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildOverviewCards(),
                      const SizedBox(height: 16),
                      _buildSecuritySection(),
                      const SizedBox(height: 16),
                      _buildMetricsSection(),
                      const SizedBox(height: 16),
                      _buildRateLimitSection(),
                      const SizedBox(height: 16),
                      _buildActiveConnections(),
                      const SizedBox(height: 16),
                      _buildLiveEvents(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildOverviewCards() {
    final metrics = _analyticsData?['metrics'] ?? {};
    final totalCalls = metrics['totalCalls'] ?? 0;
    final successRate = metrics['successRate']?.toStringAsFixed(1) ?? '0.0';
    final avgResponseTime =
        metrics['responseTime']?['average']?.toStringAsFixed(1) ?? '0.0';
    final activeUsers = _activeConnections.length;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _StatCard(
          title: 'Total API Calls',
          value: '$totalCalls',
          color: ModernSaasDesign.primary,
          icon: Icons.api,
        ),
        _StatCard(
          title: 'Success Rate',
          value: '$successRate%',
          color: ModernSaasDesign.success,
          icon: Icons.check_circle,
        ),
        _StatCard(
          title: 'Avg Response Time',
          value: '${avgResponseTime}ms',
          color: ModernSaasDesign.warning,
          icon: Icons.speed,
        ),
        _StatCard(
          title: 'Active Users',
          value: '$activeUsers',
          color: ModernSaasDesign.info,
          icon: Icons.people,
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return _CardSection(
      title: 'Security Status',
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.block, size: 20, color: Colors.red),
            title: const Text('Blocked IP Addresses'),
            subtitle: Text('${_blockedIPs.length} IPs currently blocked'),
            trailing: Chip(
              label: Text('${_blockedIPs.length}'),
              backgroundColor: Colors.red.withOpacity(0.1),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.warning, size: 20, color: Colors.orange),
            title: const Text('Failed Attempts'),
            subtitle: Text('${_failedAttempts.length} recent failed attempts'),
            trailing: Chip(
              label: Text('${_failedAttempts.length}'),
              backgroundColor: Colors.orange.withOpacity(0.1),
            ),
          ),
          if (_blockedIPs.isNotEmpty)
            ..._blockedIPs.take(3).map((ip) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.computer, size: 16),
                  title: Text(ip['ip'] ?? 'Unknown'),
                  subtitle: Text(
                      'Expires: ${ip['expiresAt']?.split('T').isNotEmpty == true ? ip['expiresAt']?.split('T')[0] ?? 'Unknown' : 'Unknown'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.lock_open, size: 16),
                    onPressed: () => _unblockIpAddress(ip['ip']),
                    tooltip: 'Unblock this IP',
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildMetricsSection() {
    final metrics = _analyticsData?['metrics'] ?? {};
    final endpointStats = metrics['endpointStats'] ?? {};
    final userPatterns = _analyticsData?['userPatterns'] ?? [];

    return Column(
      children: [
        _CardSection(
          title: 'Top Endpoints',
          child: Column(
            children: endpointStats.entries.take(5).map<Widget>((entry) {
              final endpoint = entry.key;
              final stats = entry.value;
              return ListTile(
                dense: true,
                leading: const Icon(Icons.http, size: 16),
                title: Text(endpoint),
                subtitle: Text(
                    'Calls: ${stats['count']} • Avg: ${stats['avgTime']?.toStringAsFixed(1) ?? '0'}ms'),
                trailing: Chip(
                  label: Text(
                      '${stats['successRate']?.toStringAsFixed(0) ?? '0'}%'),
                  backgroundColor: (stats['successRate'] ?? 0) > 90
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        _CardSection(
          title: 'Top Users',
          child: Column(
            children: userPatterns.take(5).map<Widget>((user) {
              final displayName =
                  user['userEmail'] ?? user['userId'] ?? 'Unknown';
              return ListTile(
                dense: true,
                leading: const Icon(Icons.person, size: 16),
                title: Text(displayName),
                subtitle: Text(
                    'Calls: ${user['totalCalls']} • Last: ${user['lastActivity']?.split('T').isNotEmpty == true ? user['lastActivity']?.split('T')[0] ?? 'Unknown' : 'Unknown'}'),
                trailing: Chip(
                  label: Text(user['activityLevel'] ?? 'low'),
                  backgroundColor: user['activityLevel'] == 'high'
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRateLimitSection() {
    return _CardSection(
      title: 'Rate Limit',
      child: Column(
        children: () {
          final List<Widget> items = [];

          // Show configured limits (if available)
          final data = _rateLimitConfig;
          if (data == null) {
            items.add(const ListTile(
              dense: true,
              title: Text('No rate limit configuration data'),
              leading: Icon(Icons.info, size: 16),
            ));
          } else if (data is Map) {
            final mapData = data as Map;
            mapData.entries
                .where((entry) => entry.key != 'default')
                .take(6)
                .forEach((entry) {
              final endpoint = entry.key.toString();
              final cfg = entry.value;
              final maxVal = _asInt(cfg is Map ? cfg['max'] : null);
              final windowMsVal =
                  _asInt(cfg is Map ? cfg['windowMs'] : null, fallback: 60000);

              items.add(ListTile(
                dense: true,
                leading: const Icon(Icons.lock_clock, size: 16),
                title: Text(endpoint),
                subtitle: Text(
                    '$maxVal requests per ${windowMsVal ~/ 60000} minutes'),
                trailing: Chip(
                  label: Text('$maxVal'),
                  backgroundColor: maxVal <= 5
                      ? Colors.red.withOpacity(0.1)
                      : maxVal <= 10
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                ),
              ));
            });
          } else if (data is List) {
            final listData = data as List;
            for (final item in listData.take(6)) {
              final cfg = item;
              String endpoint = 'Endpoint';
              if (cfg is Map) {
                endpoint = (cfg['endpoint'] ??
                        cfg['route'] ??
                        cfg['path'] ??
                        cfg['key'] ??
                        'Endpoint')
                    .toString();
              } else if (cfg != null) {
                endpoint = cfg.toString();
              }

              final maxVal = _asInt(cfg is Map ? cfg['max'] : null);
              final windowMsVal =
                  _asInt(cfg is Map ? cfg['windowMs'] : null, fallback: 60000);

              items.add(ListTile(
                dense: true,
                leading: const Icon(Icons.lock_clock, size: 16),
                title: Text(endpoint),
                subtitle: Text(
                    '$maxVal requests per ${windowMsVal ~/ 60000} minutes'),
                trailing: Chip(
                  label: Text('$maxVal'),
                  backgroundColor: maxVal <= 5
                      ? Colors.red.withOpacity(0.1)
                      : maxVal <= 10
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                ),
              ));
            }
          }

          // Divider between config and current rate-limited users
          items.add(const Divider());

          // Aggregate current rate-limited entries by IP (blocked IPs + failed attempts)
          final Map<String, Map<String, dynamic>> rateLimitedByIp = {};

          for (final fa in _failedAttempts) {
            final ip = fa is Map ? (fa['ip']?.toString() ?? '') : '';
            if (ip.isEmpty) continue;
            rateLimitedByIp[ip] = {
              'ip': ip,
              'attempts': _asInt(fa['attempts']),
              'lastAttemptAt': (fa['lastAttemptAt'] ?? '').toString(),
              'blockedUntil': null,
            };
          }

          for (final b in _blockedIPs) {
            final ip = b is Map ? (b['ip']?.toString() ?? '') : '';
            if (ip.isEmpty) continue;
            final existing = rateLimitedByIp[ip] ??
                {
                  'ip': ip,
                  'attempts': 0,
                  'lastAttemptAt': '',
                };
            existing['blockedUntil'] = (b['expiresAt'] ?? '').toString();
            rateLimitedByIp[ip] = existing;
          }

          final entries = rateLimitedByIp.values.toList();
          // Sort: blocked first, then by attempts desc
          entries.sort((a, b) {
            final aBlocked = (a['blockedUntil'] ?? '').toString().isNotEmpty;
            final bBlocked = (b['blockedUntil'] ?? '').toString().isNotEmpty;
            if (aBlocked != bBlocked) return bBlocked ? 1 : -1; // blocked first
            return (_asInt(b['attempts']) - _asInt(a['attempts']));
          });

          items.add(ListTile(
            leading: const Icon(Icons.security, size: 18),
            title: const Text('Rate-limited Users (by IP)'),
            subtitle: Text('${entries.length} entries'),
            trailing: TextButton.icon(
              onPressed: entries.isEmpty
                  ? null
                  : () async {
                      // Reset all - use with caution
                      try {
                        final res = await _api.post(
                          'api/security/rate-limit/reset',
                          body: {'resetAll': true},
                        );
                        if (!mounted) return;
                        if (res is Map && res['success'] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('All rate limits reset')),
                          );
                          _loadAll();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Failed to reset all: ${res is Map ? (res['message'] ?? 'Unknown error') : 'Unknown error'}')),
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error resetting all: $e')),
                        );
                      }
                    },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset All'),
            ),
          ));

          if (entries.isEmpty) {
            items.add(const ListTile(
              dense: true,
              leading: Icon(Icons.verified_user, size: 16, color: Colors.green),
              title: Text('No users are currently rate limited'),
            ));
          } else {
            items.addAll(entries.take(10).map((e) {
              final ip = (e['ip'] ?? 'Unknown').toString();
              final attempts = _asInt(e['attempts']);
              final lastAttemptAt = (e['lastAttemptAt'] ?? '').toString();
              final blockedUntil = (e['blockedUntil'] ?? '').toString();
              final isBlocked = blockedUntil.isNotEmpty;
              final subtitleParts = <String>[
                'Attempts: $attempts',
                if (lastAttemptAt.isNotEmpty)
                  'Last: ${(lastAttemptAt.split('T').isNotEmpty ? lastAttemptAt.split('T').first : lastAttemptAt)}',
                if (isBlocked)
                  'Blocked until: ${(blockedUntil.split('T').length > 1 ? '${blockedUntil.split('T')[0]} ${blockedUntil.split('T')[1].substring(0, 5)}' : blockedUntil)}',
              ];

              return ListTile(
                dense: true,
                leading: Icon(
                  isBlocked ? Icons.lock : Icons.error_outline,
                  size: 16,
                  color: isBlocked ? Colors.red : Colors.orange,
                ),
                title: Text(ip),
                subtitle: Text(subtitleParts.join(' • ')),
                trailing: TextButton.icon(
                  onPressed: () => _resetRateLimitForIp(ip),
                  icon: const Icon(Icons.restore_from_trash, size: 16),
                  label: const Text('Reset'),
                ),
              );
            }));
          }

          return items;
        }(),
      ),
    );
  }

  int _asInt(dynamic v, {int fallback = 0}) {
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  Widget _buildActiveConnections() {
    return _CardSection(
      title: 'Active Connections',
      child: Column(
        children: _activeConnections.isEmpty
            ? [
                const ListTile(
                  dense: true,
                  title: Text('No active connections'),
                  leading: Icon(Icons.wifi_off, size: 16),
                )
              ]
            : _activeConnections.take(5).map<Widget>((connection) {
                return ListTile(
                  dense: true,
                  leading:
                      const Icon(Icons.wifi, size: 16, color: Colors.green),
                  title: Text(connection['email'] ??
                      connection['userId'] ??
                      connection['ip'] ??
                      'Unknown'),
                  subtitle: Text(
                      'Connected: ${connection['connectedAt']?.split('T').length > 1 ? connection['connectedAt']?.split('T')[1]?.substring(0, 5) ?? 'Unknown' : 'Unknown'}'),
                  trailing: Chip(
                    label: Text('${connection['requests'] ?? 0}'),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                  ),
                );
              }).toList(),
      ),
    );
  }

  Widget _buildLiveEvents() {
    return _CardSection(
      title: 'Live (SSE)',
      child: Column(
        children: _liveEvents.map<Widget>((ev) {
          final method = ev['method'] ?? '';
          final path = ev['path'] ?? '';
          // Backend payload uses 'status' for HTTP status code
          final status = (ev['status'] ?? '').toString();
          final ip = ev['ip'] ?? '';
          final userEmail = ev['userEmail'] ?? '';
          final userInfo = userEmail.isNotEmpty ? ' • User: $userEmail' : '';
          return ListTile(
            dense: true,
            leading: const Icon(Icons.bolt, size: 20),
            title: Text('$method $path'),
            subtitle: Text('Status: $status • IP: $ip$userInfo'),
          );
        }).toList(),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData? icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(title,
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              )),
        ],
      ),
    );
  }
}

class _CardSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.black12.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Divider(height: 20),
          child,
        ],
      ),
    );
  }
}
