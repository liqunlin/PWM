#Author:YANCHAO
FROM centos
MAINTAINER yanchao@jieyuechina.com
ENV CONFD_DIR=/etc/
ENV CONSUL_IP=10.50.182.65
ENV CONSUL_IP=8500
WORKDIR $CONFD_DIR
ADD confd.tar.gz /etc/
ADD confd2.tar.gz /etc/
ADD confd /usr/bin/
ADD install.sh /opt/
ADD prometheus /usr/bin/
ADD promtool /usr/bin/
RUN chmod +x /opt/install.sh
RUN chmod +x /usr/bin/prometheus
RUN chmod +x /usr/bin/promtool
RUN chmod +x /usr/bin/confd && mkdir -p /etc/config && mkdir -p /etc/config/rules
EXPOSE 9090
ENTRYPOINT sh /opt/install.sh ${CONSUL_IP} ${ALTERMANAGER_IP} ${CONSUL_PORT}
