script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh
mysql_root_password=$1

if [-z "$mysql_root_password"]; then
    echo Input MYSQL root password Missing
    exit
if

component="shipping"
func_schema_setup=mysql
func_java