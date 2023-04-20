app_user =roboshop

print_head() {
  echo -e "\e[36m>>>>>>>>> $1 <<<<<<<<\e[0m"   
}

func_nodejs() {
print_head Configuring Node js Repos 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

print_head Install NodeJs  
yum install nodejs -y

print_head Add Application User 
useradd  ${app_user} #roboshop

print_head Create Application Directory  
rm -rf /app
mkdir /app 

print_head Download App content  
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 

print_head Unzip App content  
unzip /tmp/${component}.zip
#cd /app

print_head Install Nodejs Dependencies  
npm install 

print_head Copy Catalogue SystemD file
cp $script_path/${component}.service /etc/systemd/system/${component}.service

print_head Start Cart Service  
systemctl daemon-reload
systemctl enable ${component} 
systemctl start ${component}

}