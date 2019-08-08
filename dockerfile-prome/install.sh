#!/bin/bash
mkdir -p /etc/config/rules
sed -i 's/10.50.182.65:9093/'$2'/g' /etc/confd2/templates/prometheus.conf.tmpl

nohup /usr/bin/confd -confdir=/etc/confd -config-file=/etc/confd/conf.d/config.toml -onetime=false -interval=3 -backend consul -node $1:$3 -log-level=debug &
nohup /usr/bin/confd -confdir=/etc/confd2 -config-file=/etc/confd2/conf.d/config.toml -onetime=false -interval=3 -backend consul -node $1:$3 -log-level=debug &
sleep 5

/usr/bin/prometheus --config.file=/etc/config/prometheus.yml
