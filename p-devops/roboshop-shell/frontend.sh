script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh# echo ${app_user}
# echo $script_path

func_print_head "install nginx"
apt install nginx -y 
func_status_check $?

func_print_head  "Copy roboshop Config file"
cp $script_path/roboshop.conf   /etc/nginx/default.d/roboshop.conf 
func_status_check $?

func_print_head "Clean Old App content"
rm -rf /usr/share/nginx/html/*   &>>$log_file
func_status_check $?

func_print_head "Download App content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
func_status_check $?

func_print_head "Extracting App Content"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
func_status_check $?

func_print_head "Start Nginx"
systemctl restart nginx 
systemctl enable nginx 
func_status_check $?