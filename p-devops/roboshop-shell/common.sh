app_user =roboshop

func_print_head() {
  echo -e "\e[35m>>>>>>>>> $1 <<<<<<<<\e[0m"   
}

#mongodb install
func_schema_setup() {
    if [ "$schema_setup" == "mango"]; then
      func_print_head Set systemD service 
      cp $script_path/mongo.repo  /etc/yum.repos.d/mongo.repo

      func_print_head Install mongodb client 
      yum install mongodb-org-shell -y

      func_print_head Load schema 
      mongo --hostmongodb-dev.rdevops72online </app/schema/${component}.js
    if

    if [ "$schema_setup" == "mysql" ]; then
        func_print_head "Install mysql"
        yum install mysql -y 

        func_print_head "Load schema" 
        mysql -h mysql-dev.rdevops72.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql 
    if
}


#common step on all line
func_app_prereq() {
  func_print_head "Add Application User"
  useradd ${app_user}

  func_print_head "Create Application Dir"
  rm -rf /app
  mkdir /app 

  func_print_head "Download application content" 
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 

  func_print_head "Extract Application content"
  cd /app 
  unzip /tmp/${component}.zip
  #cd /app 

  # func_print_head "Download mvn dependencies" 
  # mvn clean package 
  # mv target/${component}-1.0.jar ${component}.jar 
}


#systemd setup
func_systemd_setup() {
  func_print_head "Copy Catalogue SystemD file"
  cp $script_path/${component}.service /etc/systemd/system/${component}.service

  func_print_head "Start ${component} Service"
  systemctl daemon-reload
  systemctl enable ${component} 
  systemctl start ${component}
}



#install Node js
func_nodejs() {
  func_print_head "Configuring Node js Repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "Install NodeJs"
  yum install nodejs -y

  #func_app_prereq
  func_print_head "Add Application User" 
  useradd  ${app_user} #roboshop

  func_print_head "Create Application Directory"
  rm -rf /app
  mkdir /app 

  func_print_head "Download App content"  
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
  cd /app 

  func_print_head "Unzip App content"  
  unzip /tmp/${component}.zip
  #cd /app
  
  func_print_head "Install Nodejs Dependencies"
  npm install 
  
  func_schema_setup
  func_systemd_setup
  

}

#install 
func_java() {
  func_print_head "Install mvn" 
  yum install maven -y

  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS[0m"
  else 
    echo -e "\e[31mFAILURE[0m"
  func_app_prereq
  if

  func_print_head "Download mvn dependencies" 
  mvn clean package 
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS[0m"
  else 
    echo -e "\e[31mFAILURE[0m"
  func_app_prereq
  if
  mv target/${component}-1.0.jar ${component}.jar
  func_schema_setup
  func_systemd_setup

}