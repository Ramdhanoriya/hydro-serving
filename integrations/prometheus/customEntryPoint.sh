#!/bin/sh

[ -z "$MANAGER_HOST" ] && MANAGER_HOST="localhost"
[ -z "$MANAGER_PORT" ] && MANAGER_PORT="8080"

mkdir -p /var/targets

cat <<'EOF' > /etc/prometheus/prometheus.yml
global:
  scrape_interval:     15s
  evaluation_interval: 15s
rule_files:
# - "first.rules"
scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node'
    scrape_interval: 10s
    scrape_timeout: 5s
    static_configs:
      - targets: ['nodeexporter:9100']
        labels: {'host': 'host1'}
  - job_name: 'containers'
    scrape_interval: 10s
    scrape_timeout: 5s
    static_configs:
      - targets: ['cadvisor:8080']
        labels: {'host': 'host1'}
  - job_name: 'kafka'
    static_configs:
      - targets: ['kafka:1100']
  - job_name: 'overwritten-default'
    file_sd_configs:
      - files: ['/var/targets/*.json']
    relabel_configs:
      - source_labels: [serviceId,instanceId,serviceType]
        target_label: __metrics_path__
        separator: /
        replacement: /api/v1/prometheus/proxyMetrics/$1
      - source_labels: []
        target_label: __address__
EOF
cat <<EOF >> /etc/prometheus/prometheus.yml
        replacement: $MANAGER_HOST:$MANAGER_PORT
EOF

while true; do curl -s http://$MANAGER_HOST:$MANAGER_PORT/api/v1/prometheus/services > /tmp/allServices.json; cp /tmp/allServices.json /var/targets/allServices.json; curl -X POST http://localhost:9090/-/reload ; sleep 60; done &
exec /bin/prometheus -config.file=/etc/prometheus/prometheus.yml \
                -storage.local.path=/prometheus \
                -web.console.libraries=/usr/share/prometheus/console_libraries \
                -web.console.templates=/usr/share/prometheus/consoles