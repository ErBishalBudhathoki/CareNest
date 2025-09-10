# Monitoring Dashboard Data Flow Documentation

## Overview
This document explains what data the monitoring dashboards receive and send, providing a complete picture of the data flow in the invoice system's monitoring infrastructure.

## Data Sources and Flow

### 1. Backend Application Data Generation

#### Log Data Generated:
- **HTTP Requests/Responses**: All API calls with timestamps, methods, endpoints
- **Business Events**: Invoice generation, user actions, system operations
- **Error Logs**: Application errors, validation failures, system exceptions
- **Audit Logs**: User actions, data changes, security events

#### Metrics Data Generated:
- **System Metrics**: Memory usage, CPU, load averages
- **Business Metrics**: Organizations, users, clients, assignments counts
- **Application Performance**: Response times, request counts, error rates

### 2. Data Collection Layer

#### Promtail (Log Collection)
**Location**: `/app/logs/` directory
**Configuration**: `/backend/docker/promtail/promtail-config.yml`

**Data Sources**:
- `invoice-app-logs`: Main application logs from `/app/logs/*.log`
- `invoice-business-logs`: Business metrics logs from `/app/logs/business/*.log`
- `invoice-audit-logs`: Audit trail logs from `/app/logs/audit/*.log`
- `invoice-error-logs`: Error logs from `/app/logs/errors/*.log`

**Data Processing**:
- Parses JSON log entries
- Extracts labels: level, service, organizationId, userId, action, resource
- Sends structured data to Loki at `http://loki:3100/loki/api/v1/push`

#### Prometheus (Metrics Collection)
**Configuration**: `/backend/docker/prometheus/prometheus.yml`

**Scrape Jobs**:
1. **invoice-app** (`host.docker.internal:8080/metrics`)
   - System metrics (memory, CPU, load)
   - Application performance metrics
   - Scrape interval: 10s

2. **invoice-business-metrics** (`host.docker.internal:8080/api/metrics/business`)
   - Business KPIs: organizations, users, clients, assignments
   - Revenue and operational metrics
   - Scrape interval: 30s

3. **invoice-system-health** (`host.docker.internal:8080/api/metrics/system`)
   - System health indicators
   - Performance monitoring
   - Scrape interval: 15s

4. **Infrastructure Metrics**:
   - node-exporter: Host system metrics
   - cadvisor: Container metrics
   - grafana: Dashboard metrics
   - loki: Log system metrics

### 3. Data Storage

#### Loki (Log Storage)
**Endpoint**: `http://localhost:3100`
**Data Structure**:
```
Labels Available:
- filename, hostname, job, level
- organizationId, pid, service, service_name, userId

Job Values:
- invoice-app: Main application logs
- system: System-level logs

Service Names:
- Progress, Update, invoice-backend, system
```

#### Prometheus (Metrics Storage)
**Endpoint**: `http://localhost:9090`
**Sample Metrics**:
```
# System Metrics
nodejs_memory_rss_bytes
nodejs_memory_heap_used_bytes
system_memory_usage_percent
system_load_average_1m

# Business Metrics
invoice_organizations_total
invoice_users_total
invoice_clients_total
invoice_assignments_total
invoice_assignments_active
```

### 4. Data Visualization (Grafana)

#### Backend Logs Dashboard
**File**: `/backend/docker/provisioning/dashboards/backend-logs-dashboard.json`
**Data Queries**:

1. **Log Volume by Level**:
   ```
   sum(count_over_time({job="backend"} [5m])) by (level)
   ```
   *Note: Currently misconfigured - should use job="invoice-app"*

2. **Error Rate**:
   ```
   sum(count_over_time({job="backend"} |= "error" [5m]))
   ```
   *Note: Currently misconfigured - should use job="invoice-app"*

3. **Backend Logs Display**:
   ```
   {job="backend"}
   ```
   *Note: Currently misconfigured - should use job="invoice-app"*

#### Business Intelligence Dashboard
**Queries**: Uses Prometheus metrics for business KPIs
- Organization counts
- User activity metrics
- Assignment tracking
- Revenue analytics

#### System Overview Dashboard
**Queries**: Combines system and business metrics
- System performance indicators
- Application health metrics
- Infrastructure monitoring

### 5. Data Flow Summary

```
Backend App → Logs → Promtail → Loki → Grafana Dashboards
     ↓
   Metrics → Prometheus → Grafana Dashboards
```

**Real-time Data Flow**:
1. Backend generates logs and exposes metrics endpoints
2. Promtail scrapes logs every few seconds and sends to Loki
3. Prometheus scrapes metrics every 10-30 seconds
4. Grafana queries both Loki and Prometheus for dashboard visualization
5. Dashboards refresh every 5 seconds showing real-time data

### 6. Current Data Being Received/Sent

#### Live Log Data (from backend):
```
2025-08-30 02:10:11 [info]: Business Event
2025-08-30 02:10:11 [http]: HTTP Request
2025-08-30 02:10:11 [http]: HTTP Response
```

#### Live Metrics Data:
```
invoice_organizations_total 4
invoice_users_total 5
invoice_clients_total 3
invoice_assignments_total 4
invoice_assignments_active 0
system_memory_usage_percent 98.26
```

### 7. Dashboard Access Points

- **Grafana UI**: `http://localhost:3001`
- **Prometheus UI**: `http://localhost:9090`
- **Loki API**: `http://localhost:3100`
- **Backend Metrics**: `http://localhost:8080/metrics`
- **Business Metrics**: `http://localhost:8080/api/metrics/business`

### 8. Data Retention and Performance

- **Refresh Rate**: Dashboards update every 5 seconds
- **Scrape Intervals**: 10-30 seconds depending on data type
- **Time Range**: Default 1 hour view, configurable
- **Data Labels**: Organized by job, service, organization, user for filtering

This monitoring system provides comprehensive visibility into both technical performance and business operations of the invoice application.