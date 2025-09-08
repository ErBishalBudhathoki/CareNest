#!/bin/bash

echo "=== Dashboard Data Diagnostic ==="
echo

echo "1. Checking backend metrics availability:"
curl -s http://localhost:8080/api/metrics/business | grep -E '^(invoice_|# HELP invoice_)' | head -10
echo

echo "2. Checking Prometheus scraping status:"
docker exec invoice-prometheus wget -qO- 'http://localhost:9090/api/v1/targets' | grep -A5 -B5 "invoice"
echo

echo "3. Testing Prometheus query for available metric:"
docker exec invoice-prometheus wget -qO- 'http://localhost:9090/api/v1/query?query=invoice_organizations_total' 2>/dev/null
echo

echo "4. Checking Loki logs ingestion:"
curl -s 'http://localhost:3100/loki/api/v1/query?query={job="invoice-app"}' | head -200
echo

echo "5. Checking Grafana data source connectivity:"
docker exec invoice-grafana curl -s 'http://invoice-prometheus:9090/api/v1/query?query=up'
echo

echo "6. Checking if dashboards are properly provisioned:"
docker exec invoice-grafana ls -la /etc/grafana/provisioning/dashboards/
echo

echo "=== End Diagnostic ==="