#!/bin/bash

sed -i 's/192.168.20.51/'$2'/g' /etc/confd1/templates/alertmanager.conf.tmpl
sed -i 's/888/'$4'/g' /etc/confd1/templates/alertmanager.conf.tmpl

nohup /usr/bin/confd -confdir=/etc/confd1 -config-file=/etc/confd1/conf.d/config.toml -onetime=false -interval=3 -backend consul -node $1:$3 -log-level=debug &

sleep 5

/usr/bin/alertmanager --config.file="/etc/alertmanager/alertmanager.yml"
