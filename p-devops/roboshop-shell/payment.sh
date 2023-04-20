script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh# echo ${app_user}
# echo $script_path
rabbitmq_appuser_password=$1

echo -e "\e[36m>>>>>>>>> Install python <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>> Add Application User <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[36m>>>>>>>>> Create App Dir <<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download app content <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 

echo -e "\e[36m>>>>>>>>> Extract Add content <<<<<<<<\e[0m"
cd /app 
unzip /tmp/payment.zip
#cd /app

echo -e "\e[36m>>>>>>>>> Install Dependencies <<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>> Set systemD service <<<<<<<<\e[0m"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" $script_path/payment.service 
cp $script_path/payment.service    /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>> start payment service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl start payment