script_path=$(dirname $0)  
source ${script_path}/common.sh
echo ${app_user}
echo $script_path
#exit

echo -e "\e[36m>>>>>>>>> Configuring Node js Repos <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJs  <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> Create Application Directory  <<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download App content  <<<<<<<<\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app

echo -e "\e[36m>>>>>>>>> Unzip App content  <<<<<<<<\e[0m"
unzip /tmp/user.zip
#cd /app 

echo -e "\e[36m>>>>>>>>> Install Nodejs Dependencies  <<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
#cp user.service  /etc/systemd/system/user.service
cp $script_path/user.service  /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>> start payment service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user 
systemctl start user

echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
cp mongo.repo  /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --hostmongodb-dev.rdevops72online </app/schema/user.js
