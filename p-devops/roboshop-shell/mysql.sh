source ${script_path}/common.sh
#echo ${app_user}
# echo $script_path

dnf module disable mysql -y 
cp $script_path/mysql.repo  /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld  
mysql_secure_installation --set-root-pass RoboShop@1