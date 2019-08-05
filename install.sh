#!/bin/bash
BASE_DIR=/opt/PWM

cd $BASE_DIR && sed -i '/CONSUL_IP/d' PWM/settings.py
cd $BASE_DIR && echo "CONSUL_IP = '$1'" >> PWM/settings.py

cd $BASE_DIR && sed -i '/MONTIOR_REDIS/d' PWM/settings.py
cd $BASE_DIR && echo "MONTIOR_REDIS = '$2'" >> PWM/settings.py

cd $BASE_DIR && sed -i 's/10.50.182.65:9093/'$3'/g' PWM/settings.py

cd $BASE_DIR && python manage.py runserver 0.0.0.0:888
