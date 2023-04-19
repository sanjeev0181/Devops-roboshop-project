 source ${script_path}/common.sh
# echo ${app_user}
# echo $script_path

echo -e "\e[36m>>>>>>>>> Install mvn <<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> Create App Dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download app content <<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 

echo -e "\e[36m>>>>>>>>> Extract Add content <<<<<<<<\e[0m"
cd /app 
unzip /tmp/shipping.zip
#cd /app 

echo -e "\e[36m>>>>>>>>> Download mvn dependencies <<<<<<<<\e[0m"
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

# echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
# cp shipping.service  /etc/systemd/system/shipping.service

# echo -e "\e[36m>>>>>>>>> start payment service <<<<<<<<\e[0m"
# systemctl daemon-reload
# systemctl enable shipping 
#systemctl start shipping

echo -e "\e[36m>>>>>>>>> Install mysql <<<<<<<<\e[0m"
yum install mysql -y 

echo -e "\e[36m>>>>>>>>> Load schema <<<<<<<<\e[0m"
mysql -h mysql-dev.rdevops72.online -uroot -pRoboShop@1 < /app/schema/shipping.sql 

echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
cp $script_path/shipping.service  /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>>>> start payment service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping 
systemctl restart shipping