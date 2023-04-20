script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh

component=catalogue

func_nodejs

echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
cp mongo.repo  /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --hostmongodb-dev.rdevops72online </app/schema/user.js
