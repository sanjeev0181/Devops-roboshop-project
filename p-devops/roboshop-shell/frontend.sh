script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh# echo ${app_user}
# echo $script_path

apt install nginx -y 
cp $script_path/roboshop.conf   /etc/nginx/default.d/roboshop.conf 
rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

systemctl restart nginx 
systemctl enable nginx 
