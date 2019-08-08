#Author:YANCHAO
FROM centos
MAINTAINER yanchao@jieyuechina.com
ENV EZ_DIR=/opt/
ENV CONSUL_IP=10.50.182.65
ENV PWM_IP=10.50.182.65
ENV CONSUL_PORT=8500
ENV PWM_PORT=888
ADD alertmanager /usr/bin/
ADD amtool /usr/bin/
ADD confd1.tar.gz /etc/
ADD confd /usr/bin/
ADD install.sh /opt/
RUN chmod +x /usr/bin/alertmanager
RUN chmod +x /usr/bin/amtool && mkdir -p /etc/alertmanager
RUN chmod +x /usr/bin/confd
RUN chmod +x /opt/install.sh
EXPOSE 9093
ENTRYPOINT sh /opt/install.sh ${CONSUL_IP} ${PWM_IP} ${CONSUL_PORT} ${PWM_PORT}


