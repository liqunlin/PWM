#!/bin/bash
BASE_DIR=/opt/PWM

if [ ${16} ];
then
#cd $BASE_DIR && /bin/cp -f PWM/settings_mysql.py PWM/settings.py
cd $BASE_DIR && sed -i 's/pwm_db/'${15}'/g' PWM/settings_mysql.py
cd $BASE_DIR && sed -i 's/pwm_user/'${13}'/g' PWM/settings_mysql.py
cd $BASE_DIR && sed -i 's/pwm_passwd/'${14}'/g' PWM/settings_mysql.py
cd $BASE_DIR && sed -i 's/pwm_host/'${16}'/g' PWM/settings_mysql.py
cd $BASE_DIR && sed -i 's/pwm_port/'${17}'/g' PWM/settings_mysql.py
cd $BASE_DIR && /bin/cp -f PWM/settings_mysql.py PWM/settings.py

echo ${16} >> /tmp/test
echo ${17} >> /tmp/test
fi

cd $BASE_DIR && sed -i '/CONSUL_IP/d' PWM/settings.py
cd $BASE_DIR && echo "CONSUL_IP = '$1'" >> PWM/settings.py

cd $BASE_DIR && sed -i '/CONSUL_PORT/d' PWM/settings.py
cd $BASE_DIR && echo "CONSUL_PORT = $7" >> PWM/settings.py

cd $BASE_DIR && sed -i '/MONTIOR_REDIS/d' PWM/settings.py
cd $BASE_DIR && echo "MONTIOR_REDIS = '$2'" >> PWM/settings.py

cd $BASE_DIR && sed -i '/MONTIOR_PORT/d' PWM/settings.py
cd $BASE_DIR && echo "MONTIOR_PORT = $6" >> PWM/settings.py

cd $BASE_DIR && sed -i 's/10.50.182.65:9093/'$3'/g' PWM/settings.py


cd $BASE_DIR && sed -i '/REDIS_IP/d' PWM/settings.py
cd $BASE_DIR && echo "REDIS_IP = '$4'" >> PWM/settings.py

cd $BASE_DIR && sed -i '/REDIS_PORT/d' PWM/settings.py
cd $BASE_DIR && echo "REDIS_PORT = $5" >> PWM/settings.py

cd $BASE_DIR && sed -i '/WX_URL/d' PWM/settings.py
cd $BASE_DIR && echo "WX_URL = $8" >> PWM/settings.py

cd $BASE_DIR && sed -i '/SMS_URL/d' PWM/settings.py
cd $BASE_DIR && echo "SMS_URL = $9" >> PWM/settings.py

cd $BASE_DIR && sed -i '/SENDMAIL_SMTP/d' PWM/settings.py
cd $BASE_DIR && echo "SENDMAIL_SMTP = ${10}" >> PWM/settings.py

cd $BASE_DIR && sed -i '/SENDMAIL_SENDER/d' PWM/settings.py
cd $BASE_DIR && echo "SENDMAIL_SENDER = ${11}" >> PWM/settings.py

cd $BASE_DIR && sed -i '/SENDMAIL_SENDER_PASSWORD/d' PWM/settings.py
cd $BASE_DIR && echo "SENDMAIL_SENDER_PASSWORD = ${12}" >> PWM/settings.py

cd $BASE_DIR && python manage.py makemigrations
cd $BASE_DIR && python manage.py migrate


cd $BASE_DIR && python manage.py runserver 0.0.0.0:888
