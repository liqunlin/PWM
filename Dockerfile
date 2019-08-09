#Author:YANCHAO
FROM centos
MAINTAINER yanchao@jieyuechina.com
ENV EZ_DIR=/opt/
ENV PROJECT_DIR=/opt/PWM
ENV PIP_DIR=/opt/pip-19.1.1
ENV CONSUL_IP="10.50.182.65"
ENV MONTIOR_REDIS="10.50.182.65"
ENV ALERTMANAGER_HTTP="10.50.182.65:9093"
ENV REDIS_IP="10.50.182.65"
ENV REDIS_PORT=6380
ENV MONTIOR_PORT=6380
ENV CONSUL_PORT=8500
ENV WX_URL="http://outrel.jieyue.com/outrel/api/externalplatform/interfaceRest/extInterface/v2"
ENV SMS_URL="http://172.18.100.168:20019/esbsmstrue/api/sms/general/send"
ENV SENDMAIL_SMTP="smtp.jieyuechina.com:25"
ENV SENDMAIL_SENDER="chaoyan1@jieyuechina.com"
ENV SENDMAIL_SENDER_PASSWORD="aaa"
ENV MYSQL_USER=""
ENV MYSQL_PASSWORD=""
ENV MYSQL_DB=""
ENV MYSQL_IP=""
ENV MYSQL_PORT=3306
ADD PWM.tar.gz /opt/
ADD 19.1.1.tar.gz /opt/
ADD ez_setup.py /opt/
ADD install.sh /opt/
WORKDIR $EZ_DIR
RUN python ez_setup.py
WORKDIR $PIP_DIR
RUN yum install gcc gcc-c++ gcc-devel python-devel mysql-devel -y
RUN python setup.py install
WORKDIR $PROJECT_DIR
RUN pip install -r requirements.txt
RUN python manage.py makemigrations
RUN python manage.py migrate
RUN chmod +x /opt/install.sh
EXPOSE 888
#CMD ["python manage.py runserver 0.0.0.0:888"]
#ENTRYPOINT ["/bin/bash","-c"]
ENTRYPOINT /opt/install.sh ${CONSUL_IP} ${MONTIOR_REDIS} ${ALERTMANAGER_HTTP} ${REDIS_IP} ${REDIS_PORT} ${MONTIOR_PORT} ${CONSUL_PORT} ${WX_URL} ${SMS_URL} ${SENDMAIL_SMTP} ${SENDMAIL_SENDER} ${SENDMAIL_SENDER_PASSWORD} ${MYSQL_USER} ${MYSQL_PASSWORD} ${MYSQL_DB} ${MYSQL_IP} ${MYSQL_PORT}
