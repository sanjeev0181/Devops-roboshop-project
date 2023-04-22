script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

if [-z "$rabbitmq_appuser_password"]; then
    echo Input Roboshop_appuser_password Missing
    exit
fi

func_print_head "Set ErLang Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash  &>>$log_file
func_status_check $?

func_print_head "Install ErLang & Rabbitmg"
yum install erlang rabbitmq-server -y  &>>$log_file
func_status_check $?

func_print_head "Setup Rabbitmq Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>>$log_file
func_status_check $?
#yum install rabbitmq-server -y 

func_print_head "Start Rabbitmq Service"
systemctl enable rabbitmq-server  &>>$log_file
systemctl start rabbitmq-server   &>>$log_file
func_status_check $?

func_print_head "Add Application User in Rabbitmq"
rabbitmqctl add_user roboshop  ${rabbitmq_appuser_password}#roboshop123  &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>>$log_file
func_status_check $?