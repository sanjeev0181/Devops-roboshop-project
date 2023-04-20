script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
yum install erlang -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
yum install rabbitmq-server -y 
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 
rabbitmqctl add_user roboshop  ${rabbitmq_appuser_password}#roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"