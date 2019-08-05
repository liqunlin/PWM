#Author:YANCHAO
FROM centos
MAINTAINER yanchao@jieyuechina.com
ENV EZ_DIR=/opt/
ENV PROJECT_DIR=/opt/PWM
ENV PIP_DIR=/opt/pip-19.1.1
ENV CONSUL_IP="10.50.182.65"
ENV MONTIOR_REDIS="10.50.182.65"
ENV ALERTMANAGER_HTTP="10.50.182.65:9093"
ADD PWM.tar.gz /opt/
ADD 19.1.1.tar.gz /opt/
ADD ez_setup.py /opt/
ADD install.sh /opt/
WORKDIR $EZ_DIR
RUN python ez_setup.py
WORKDIR $PIP_DIR
RUN python setup.py install
WORKDIR $PROJECT_DIR
RUN pip install -r requirements.txt
RUN python manage.py makemigrations
RUN python manage.py migrate
RUN chmod +x /opt/install.sh
EXPOSE 888
#CMD ["python manage.py runserver 0.0.0.0:888"]
#ENTRYPOINT ["/bin/bash","-c"]
ENTRYPOINT /opt/install.sh ${CONSUL_IP} ${MONTIOR_REDIS} ${ALERTMANAGER_HTTP}
