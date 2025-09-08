# Logging Infrastructure

This directory contains the logging infrastructure setup using Grafana, Loki, and Promtail for centralized log management and monitoring.

## Architecture Overview

The logging stack consists of:
- **Grafana**: Web-based analytics and monitoring platform for log visualization
- **Loki**: Log aggregation system that indexes metadata rather than full-text
- **Promtail**: Log collection agent that scrapes logs and sends them to Loki

```
Backend App → Log Files → Promtail → Loki → Grafana
```

## Components

### Grafana (Port 3000)
- **Purpose**: Dashboard and visualization layer
- **Features**: Pre-configured dashboards, alerting, user management
- **Access**: http://localhost:3000
- **Credentials**: admin/admin (change on first login)

### Loki (Port 3100)
- **Purpose**: Log aggregation and storage
- **Features**: Label-based indexing, efficient storage, LogQL query language
- **Storage**: Local filesystem with configurable retention
- **API**: http://localhost:3100

### Promtail (Port 9080)
- **Purpose**: Log collection and forwarding
- **Features**: File watching, log parsing, label extraction
- **Targets**: Backend application logs, system logs
- **Metrics**: http://localhost:9080/metrics

## Prerequisites

- Docker and Docker Compose installed
- Backend application running and generating logs
- Sufficient disk space for log storage (configurable retention)

## Quick Start

1. **Start the logging stack:**
   ```bash
   cd backend/docker
   docker-compose up -d
   ```

2. **Verify services are running:**
   ```bash
   docker-compose ps
   ```

3. **Access Grafana:**
   - URL: http://localhost:3000
   - Username: `admin`
   - Password: `admin`
   - Change password on first login

4. **Check Loki status:**
   ```bash
   curl http://localhost:3100/ready
   ```

## Configuration Details

### Docker Compose (`docker-compose.yml`)
- Orchestrates all three services
- Sets up networking and volume mounts
- Configures service dependencies

### Loki Configuration (`loki/loki-config.yml`)
- **Storage**: Local filesystem with 24-hour retention
- **Limits**: 5MB max query size, 30-day max query length
- **Ingestion**: Rate limiting and chunk encoding
- **API**: HTTP server on port 3100

### Promtail Configuration (`promtail/promtail-config.yml`)
- **Targets**: Monitors `../logs/*.log` files
- **Labels**: Extracts job, filename, and log level
- **Pipeline**: Parses JSON logs and extracts structured data
- **Client**: Sends logs to Loki at http://loki:3100

### Grafana Provisioning (`grafana/provisioning/`)
- **Datasources**: Auto-configures Loki connection
- **Dashboards**: Pre-built dashboard for backend logs
- **Settings**: Default admin user and basic configuration

## Log Format

The backend uses structured logging with the following format:

```json
{
  "timestamp": "2024-01-20T10:30:00.000Z",
  "level": "info",
  "message": "User authentication successful",
  "service": "backend",
  "userId": "12345",
  "endpoint": "/api/auth/login",
  "duration": 150,
  "metadata": {
    "userAgent": "Mozilla/5.0...",
    "ip": "192.168.1.100"
  }
}
```

### Log Levels
- `error`: Application errors, exceptions
- `warn`: Warning conditions, deprecated usage
- `info`: General application flow, user actions
- `debug`: Detailed debugging information

## Querying Logs

### LogQL Examples

1. **All backend logs:**
   ```logql
   {job="backend"}
   ```

2. **Error logs only:**
   ```logql
   {job="backend"} |= "error"
   ```

3. **Logs from specific endpoint:**
   ```logql
   {job="backend"} | json | endpoint="/api/auth/login"
   ```

4. **Rate of errors per minute:**
   ```logql
   rate({job="backend"} |= "error"[1m])
   ```

5. **Top error messages:**
   ```logql
   topk(10, count by (message) ({job="backend"} |= "error"))
   ```

### Dashboard Features

- **Log Volume**: Real-time log ingestion rates
- **Error Rate**: Error percentage over time
- **Response Times**: API endpoint performance
- **User Activity**: Authentication and user actions
- **System Health**: Application status and alerts

## Troubleshooting

### Common Issues

1. **Promtail not collecting logs:**
   ```bash
   # Check Promtail logs
   docker-compose logs promtail
   
   # Verify log file permissions
   ls -la ../logs/
   ```

2. **Loki storage issues:**
   ```bash
   # Check Loki logs
   docker-compose logs loki
   
   # Verify disk space
   df -h
   ```

3. **Grafana dashboard not loading:**
   ```bash
   # Restart Grafana
   docker-compose restart grafana
   
   # Check Grafana logs
   docker-compose logs grafana
   ```

### Log File Locations

- **Application logs**: `../logs/app.log`
- **Error logs**: `../logs/error.log`
- **Access logs**: `../logs/access.log`
- **Loki data**: `./loki/data/`
- **Grafana data**: `./grafana/data/`

## Maintenance

### Log Rotation

Logs are automatically rotated based on:
- **Size**: 100MB per file
- **Time**: Daily rotation
- **Retention**: 7 days for application logs, 24 hours in Loki

### Backup

```bash
# Backup Grafana dashboards
docker-compose exec grafana grafana-cli admin export-dashboard

# Backup Loki data
tar -czf loki-backup-$(date +%Y%m%d).tar.gz ./loki/data/
```

### Updates

```bash
# Update images
docker-compose pull

# Restart with new images
docker-compose up -d
```

## Security Considerations

- **Change default passwords** on first login
- **Configure HTTPS** for production deployments
- **Restrict network access** to logging ports
- **Regular updates** of Docker images
- **Log sanitization** to prevent sensitive data exposure

## Integration with Backend

The backend application integrates with this logging infrastructure through:

1. **Structured Logger** (`utils/structuredLogger.js`):
   - Outputs JSON-formatted logs
   - Includes metadata and context
   - Supports multiple log levels

2. **Log Files**:
   - Written to `logs/` directory
   - Automatically picked up by Promtail
   - Rotated and managed by the system

3. **Monitoring**:
   - Real-time log streaming
   - Error alerting and notifications
   - Performance metrics and dashboards

## Performance Tuning

### For High Volume Environments

1. **Increase Loki limits** in `loki-config.yml`:
   ```yaml
   limits_config:
     max_query_series: 10000
     max_streams_per_user: 20000
   ```

2. **Configure log sampling** in backend:
   ```javascript
   // Sample debug logs in production
   if (level === 'debug' && Math.random() > 0.1) return;
   ```

3. **Use SSD storage** for Loki data directory

4. **Monitor resource usage**:
   ```bash
   docker stats
   ```

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review Docker Compose logs: `docker-compose logs`
3. Consult official documentation:
   - [Grafana Docs](https://grafana.com/docs/)
   - [Loki Docs](https://grafana.com/docs/loki/)
   - [Promtail Docs](https://grafana.com/docs/loki/latest/clients/promtail/)

## Log Structure

The backend application outputs structured JSON logs with the following fields:
- `timestamp`: ISO 8601 timestamp
- `level`: Log level (error, warn, info, debug)
- `message`: Human-readable message
- `service`: Service name (invoice-backend)
- Additional contextual fields (userId, organizationId, etc.)

## LogQL Query Examples

### Basic Queries
```logql
# All logs from the backend service
{service="invoice-backend"}

# Error logs only
{service="invoice-backend"} |= "level":"error"

# Logs for specific organization
{service="invoice-backend"} | json | organizationId="your-org-id"

# Logs from last hour
{service="invoice-backend"}[1h]
```

### Advanced Queries
```logql
# Count errors by endpoint
sum by (endpoint) (count_over_time({service="invoice-backend"} |= "level":"error" [5m]))

# Filter by user email
{service="invoice-backend"} | json | userEmail="user@example.com"

# Search for specific error messages
{service="invoice-backend"} |~ "Database connection failed"
```

## Dashboard Features

The included dashboard provides:
- Log volume over time
- Error rate monitoring
- Top error messages
- Request/response tracking
- Performance metrics

## Troubleshooting

### Logs not appearing in Grafana
1. Check if Promtail is running: `docker-compose ps`
2. Verify log file paths in `promtail-config.yml`
3. Check Promtail logs: `docker-compose logs promtail`
4. Ensure backend is writing to the correct log directory

### Grafana connection issues
1. Verify Loki is running: `docker-compose ps loki`
2. Check Loki logs: `docker-compose logs loki`
3. Test Loki endpoint: `curl http://localhost:3100/ready`

### Performance issues
1. Adjust retention policies in `loki-config.yml`
2. Increase resource limits in `docker-compose.yml`
3. Configure log rotation for source files

## Maintenance

### Log Retention
Logs are retained for 168 hours (7 days) by default. Adjust in `loki-config.yml`:
```yaml
limits_config:
  retention_period: 168h
```

### Backup
To backup Grafana dashboards and settings:
```bash
docker-compose exec grafana grafana-cli admin export-dashboard
```

### Updates
To update the stack:
```bash
docker-compose pull
docker-compose up -d
```

## Security Considerations

- Change default Grafana admin password
- Configure authentication for production use
- Restrict network access to logging ports
- Enable HTTPS for Grafana in production
- Review log content for sensitive information

## Integration with Application

The backend application uses a structured logger that outputs JSON logs compatible with Loki. Key features:
- Automatic request/response logging
- Error tracking with stack traces
- Performance monitoring
- User activity tracking
- Database operation logging

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review Docker Compose logs
3. Consult Grafana/Loki documentation
4. Check application logs for configuration issues