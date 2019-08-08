# PWM 是一个管理prometheus alertmanager的统一管理平台

包含功能:
  1. 管理prometheus的配置
  2. 管理exporter
  3. 管理报警规则的配置
  4. 支持报警分组
  5. 支持邮件 短信 企业微信报警
  6. 配置之间用服务树方式展现
  7. 报警历史记录查询
  8. 报警静默配置

此平台优点:
  1. 支持用户组管理
  2. 通过服务树，清晰的展示数据源 报警规则 报警附属配置之间的关系
  3. 支持静默配置
  4. 支持自定义报警方式 如 短信 微信 邮件报警
  5. 减少操作人员学习成本
  6. 支持记录展示报警历史
  7. 操作管理方便 快捷
  
此平台架构图：（图中画红框的为此平台所需架构）
  django framework + vue-cli + consul + confd + prometheus + alertmanager
  其中exporter会以服务的方式注册到consul中，confd服务管理prometheus rules alertmanager的配置文件
![Image text](https://github.com/yanchao3/PWM/blob/master/img-folder/prometheus.png?raw=true)
  
PWM 功能列表


![image text](https://github.com/yanchao3/PWM/blob/master/img-folder/pwm2.png?raw=true)

PWM dashboard
![Image text](https://github.com/yanchao3/PWM/blob/master/img-folder/dashboard.png?raw=true)

PWM 报警规则
![Image text](https://github.com/yanchao3/PWM/blob/master/img-folder/rules1.png?raw=true)
![Image text](https://github.com/yanchao3/PWM/blob/master/img-folder/rules2.png?raw=true)

PWM 静默管理
![image text](https://github.com/yanchao3/PWM/blob/master/img-folder/silence.png?raw=true)
![image text](https://github.com/yanchao3/PWM/blob/master/img-folder/silence2.png?raw=true)

# 安装部署

python-2.7.5 Django-1.11.22 djangorestframework-3.9.4 node-v10.15.0 npm-6.4.1
  
  ##docker启动方式, 包括: 后端代码 前端代码 prometheus+confd alertmanager+confd consul
  1. 安装compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  
  chmod +x /usr/local/bin/docker-compose
  
  cp /usr/local/bin/docker-compose /usr/bin/
  
  2.在PWM目录中，修改docker-compose.yml
  cd PWM
  
  vim docker-compose.yml, 把ip地址更换为本机ip地址
  sed -i 's/10.50.182.65/${self_ipaddress}/g' docker-compose.yml
  ```
  version: '3'
services:
  redis:
    image: redis:latest
    ports:
      - '6381:6379'

  consul1:
    image: consul
    container_name: node1
    ports:
      - "18500:8500"
    command: agent -server -bootstrap-expect 3 -ui -disable-host-node-id -client 0.0.0.0 -bind 0.0.0.0

  consul2:
    image: consul
    container_name: node2
    ports:
      - "18501:8500"
    command: agent -server -ui -join node1 -disable-host-node-id -client 0.0.0.0 -bind 0.0.0.0
    depends_on:
      - consul1

  consul3:
    image: consul
    container_name: node3
    ports:
      - "18502:8500"
    command: agent -server -ui -join node1 -disable-host-node-id -client 0.0.0.0 -bind 0.0.0.0
    depends_on:
      - consul1

  pwm:
    image: nginx2012/pwm_manager:v1.1.1
    ports:
      - '88:888'
    links:
      - redis
      - consul1
    environment:
      - CONSUL_IP=10.50.182.65
      - MONTIOR_REDIS= 10.50.182.65
      - ALERTMANAGER_HTTP=10.50.182.65:9093
      - REDIS_IP=10.50.182.65
      - REDIS_PORT=6381
      - MONTIOR_PORT=6381
      - CONSUL_PORT=18500
      # 企业微信url
      - WX_URL=""
      # 短信报警url
      - SMS_URL=""
      # 邮件的smtp地址
      - SENDMAIL_SMTP=""
      # 哪个邮箱进行报警邮件的发送
      - SENDMAIL_SENDER=""
      # 发送报警邮件的邮箱密码
      - SENDMAIL_SENDER_PASSWORD=""
    depends_on:
      - redis
      - consul3

  alertmanager:
    image: nginx2012/alertmanager:v1.1.1
    ports:
      - '9093:9093'
    links:
      - consul1
      - pwm
    environment:
      - CONSUL_IP=10.50.182.65
      - CONSUL_PORT=18500
      - PWM_PORT=88
      - PWM_IP=10.50.182.65
    depends_on:
      - consul3
      - pwm
 
  prometheus:
    image: nginx2012/prometheus:v1.1.1
    ports: 
      - '9091:9090'
    links:
      - consul1
    environment:
      - CONSUL_IP=10.50.182.65
      - CONSUL_PORT=18500
      - ALTERMANAGER_IP=10.50.182.65:9093
    depends_on:
      - consul3
      - alertmanager

  pwm-web:
    image: nginx2012/pwm-web_manager:v1.1.1
    links:
      - pwm
    ports:
      - '8088:8080'
    environment:
      - DJANGO_ADDESS=10.50.182.65
      - DJANGO_PORT=88
      - WEB_PORT=8080
    depends_on:
      - pwm
  ```
  
  3. cd PWM && docker-compose up
  
  4. 访问http://ip:8088 管理界面地址
  
     访问http://ip:88 后台接口地址
    
     访问http://ip:18500 consul管理界面地址
     
     访问http://ip:9091 prometheus管理界面地址
     
     访问http://ip:9093 alertmanaer管理界面地址
  
  
