# Invoice System Monitoring & Analytics

This directory contains comprehensive monitoring and analytics setup for the Invoice System using Grafana, Prometheus, Loki, and related tools.

## 📊 Overview

The monitoring stack provides:
- **Business Metrics**: Invoice generation, revenue tracking, NDIS compliance
- **System Health**: CPU, memory, disk, network monitoring
- **Client Analytics**: Activity patterns, engagement, retention
- **Error Tracking**: Application errors, validation failures
- **Performance Monitoring**: Response times, database performance
- **Log Aggregation**: Centralized logging with search capabilities

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Invoice App   │───▶│   Prometheus    │───▶│    Grafana      │
│  (Node.js API)  │    │  (Metrics DB)   │    │  (Dashboards)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│    Promtail     │───▶│      Loki       │───▶│   Log Queries   │
│ (Log Collector) │    │   (Log DB)      │    │   & Analysis    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │
         ▼
┌─────────────────┐
│  Alertmanager   │
│   (Alerts)      │
└─────────────────┘
```

## 🚀 Quick Start

### 1. Start Monitoring Stack

```bash
cd backend/docker
docker-compose -f docker-compose.monitoring.yml up -d
```

### 2. Access Dashboards

- **Grafana**: http://localhost:3001 (admin/admin123)
- **Prometheus**: http://localhost:9090
- **Alertmanager**: http://localhost:9093

### 3. Import Dashboards

Dashboards are automatically provisioned from the `dashboards/` directory:
- `business-metrics-dashboard.json` - Business Intelligence
- `system-health-dashboard.json` - System Monitoring
- `client-analytics-dashboard.json` - Client Analytics

## 📈 Available Dashboards

### Business Metrics Dashboard
- **Invoice Generation Volume**: Track invoice creation rates
- **Revenue Analytics**: Monitor total, service, and expense revenue
- **NDIS Compliance**: Compliance rates and violations
- **Pricing Analytics**: Custom vs standard pricing usage
- **Client Activity**: Service hours and expense patterns
- **Performance Metrics**: Generation times and efficiency

### System Health Dashboard
- **Resource Usage**: CPU, Memory, Disk utilization
- **Network Metrics**: Latency, throughput, connections
- **Database Performance**: Query times, connection pools
- **Error Rates**: Application and system errors
- **Response Times**: API endpoint performance

### Client Analytics Dashboard
- **Top Performing Clients**: Revenue and activity leaders
- **Service Utilization**: Usage patterns and trends
- **Client Engagement**: Activity and retention metrics
- **Revenue Forecasting**: Predictive analytics
- **Growth Trends**: Client acquisition and expansion

## 🔧 Configuration

### Environment Variables

Set these in your `.env` file:

```env
# Grafana Configuration
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=your-secure-password

# Database Connection
MONGODB_URI=mongodb://localhost:27017/invoice
MONGODB_USERNAME=your-username
MONGODB_PASSWORD=your-password

# Alert Configuration
ALERT_EMAIL_FROM=alerts@your-domain.com
ALERT_EMAIL_PASSWORD=your-email-password
ALERT_WEBHOOK_SECRET=your-webhook-secret
```

### Custom Metrics

Add custom business metrics in your application:

```javascript
const { logger } = require('./utils/logger');

// Log business events
logger.business('invoice_generated', {
  organizationId: 'org123',
  amount: 1500.00,
  itemCount: 5,
  isNDISCompliant: true,
  processingTime: 250
});
```

## 📊 Metrics Reference

### Business Metrics
- `invoice_generation_total` - Total invoices generated
- `invoice_generation_duration_seconds` - Generation time
- `revenue_total` - Total revenue amount
- `ndis_compliance_rate` - NDIS compliance percentage
- `client_activity_hours` - Client service hours
- `pricing_usage_ratio` - Custom vs standard pricing

### System Metrics
- `http_requests_total` - HTTP request count
- `http_request_duration_seconds` - Request duration
- `process_resident_memory_bytes` - Memory usage
- `process_cpu_seconds_total` - CPU usage
- `mongodb_query_duration_seconds` - Database query time

### Client Metrics
- `client_engagement_score` - Engagement rating (0-1)
- `client_retention_rate` - Retention percentage
- `client_last_activity_hours` - Hours since last activity
- `client_churn_risk_score` - Churn probability (0-1)

## 🚨 Alerting

### Alert Rules

Configured alerts include:
- **Critical**: High error rates, NDIS violations, system down
- **Warning**: High response times, memory usage, client inactivity
- **Business**: Revenue drops, low generation rates

### Alert Channels
- **Email**: Critical and warning alerts
- **Webhook**: Integration with application
- **Slack**: Team notifications (configure webhook URL)

### Custom Alerts

Add custom alert rules in `prometheus/alert_rules.yml`:

```yaml
- alert: CustomBusinessAlert
  expr: your_metric > threshold
  for: 5m
  labels:
    severity: warning
  annotations:
    summary: "Custom alert triggered"
    description: "Your custom condition met"
```

## 🔍 Log Analysis

### Log Types
- **Application Logs**: General application events
- **Business Logs**: Business metrics and events
- **Audit Logs**: User actions and data changes
- **Error Logs**: Exceptions and failures

### Log Queries

Example Loki queries:

```logql
# Find errors in the last hour
{job="invoice-app"} |= "ERROR" | json | line_format "{{.timestamp}} {{.message}}"

# Business events for specific organization
{job="invoice-business"} | json | organizationId="org123"

# High-value transactions
{job="invoice-business"} | json | metric_value > 1000
```

## 🛠️ Maintenance

### Data Retention
- **Prometheus**: 200 hours (configurable)
- **Loki**: 168 hours (7 days)
- **Grafana**: Persistent dashboards and settings

### Backup

```bash
# Backup Grafana dashboards
docker exec invoice-grafana grafana-cli admin export-dashboard > backup.json

# Backup Prometheus data
docker exec invoice-prometheus tar -czf /prometheus-backup.tar.gz /prometheus
```

### Updates

```bash
# Update monitoring stack
docker-compose -f docker-compose.monitoring.yml pull
docker-compose -f docker-compose.monitoring.yml up -d
```

## 🐛 Troubleshooting

### Common Issues

1. **Grafana not loading dashboards**
   - Check provisioning directory permissions
   - Verify dashboard JSON syntax

2. **Prometheus not scraping metrics**
   - Verify application metrics endpoint
   - Check network connectivity

3. **Loki not receiving logs**
   - Check Promtail configuration
   - Verify log file permissions

### Debug Commands

```bash
# Check service status
docker-compose -f docker-compose.monitoring.yml ps

# View service logs
docker-compose -f docker-compose.monitoring.yml logs grafana
docker-compose -f docker-compose.monitoring.yml logs prometheus

# Test metrics endpoint
curl http://localhost:3000/metrics
```

## 📚 Additional Resources

- [Grafana Documentation](https://grafana.com/docs/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [Loki Documentation](https://grafana.com/docs/loki/)
- [PromQL Query Language](https://prometheus.io/docs/prometheus/latest/querying/)
- [LogQL Query Language](https://grafana.com/docs/loki/latest/logql/)

## 🤝 Contributing

To add new dashboards or metrics:
1. Create dashboard in Grafana UI
2. Export dashboard JSON
3. Save to `dashboards/` directory
4. Update provisioning configuration
5. Test with monitoring stack restart

---

**Note**: Remember to secure your monitoring stack in production with proper authentication, HTTPS, and network policies.