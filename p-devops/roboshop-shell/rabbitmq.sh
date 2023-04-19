script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh
# echo ${app_user}
# echo $script_path
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
yum install erlang -y
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
yum install rabbitmq-server -y 
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"