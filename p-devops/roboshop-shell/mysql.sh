script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh
mysql_root_password=$1

if [-z "$mysql_root_password"]; then
    echo Input mysql root password Missing
    exit
if

dnf module disable mysql -y 
cp $script_path/mysql.repo  /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld  
mysql_secure_installation --set-root-pass $mysql_root_password