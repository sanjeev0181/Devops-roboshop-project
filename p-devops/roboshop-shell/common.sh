app_user =roboshop
log_file=/tmp/roboshop.log
#rm -rf $log_file

func_print_head() {
  echo -e "\e[35m>>>>>>>>> $1 <<<<<<<<\e[0m"   
  echo -e "\e[35m>>>>>>>>> $1 <<<<<<<<\e[0m"  &>>$log_file
}

#status check
func_status_check() {
  if [ $1 -eq 0 ]; then
    echo -e "\e[32mSUCCESS[0m"
  else 
    echo -e "\e[31mFAILURE[0m"
    echo "Refer the log file /tmp/roboshop.log for more information"
    exit 1
  if
}


#mongodb install
func_schema_setup() {
    if [ "$schema_setup" == "mango"]; then
      func_print_head Set systemD service 
      cp $script_path/mongo.repo  /etc/yum.repos.d/mongo.repo   &>>$log_file
      func_status_check $?

      func_print_head Install mongodb client 
      yum install mongodb-org-shell -y  &>>$log_file
      func_status_check $?

      func_print_head Load schema 
      mongo --hostmongodb-dev.rdevops72online </app/schema/${component}.js  &>>$log_file
      func_status_check $?
    if

    if [ "$schema_setup" == "mysql" ]; then
        func_print_head "Install mysql"
        yum install mysql -y  &>>$log_file
        func_status_check $? 

        func_print_head "Load schema" 
        mysql -h mysql-dev.rdevops72.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql  &>>$log_file
        func_status_check $?
    if
}


#common step on all line
func_app_prereq() {
  func_print_head "Add Application User"
  id ${app_user}  &>>$log_file
  if [ $? -ne 0 ]; then
    useradd ${app_user}  &>>$log_file
  if 
  func_status_check $? 

  func_print_head "Create Application Dir"
  rm -rf /app
  mkdir /app
  func_status_check $?

  func_print_head "Download application content" 
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
  func_status_check $? 

  func_print_head "Extract Application content"
  cd /app 
  unzip /tmp/${component}.zip  &>>$log_file
  func_status_check $?
  #cd /app 

  # func_print_head "Download mvn dependencies" 
  # mvn clean package 
  # mv target/${component}-1.0.jar ${component}.jar 
}


#systemd setup
func_systemd_setup() {
  func_print_head "Copy Catalogue SystemD file"
  cp $script_path/${component}.service /etc/systemd/system/${component}.service  &>>$log_file
  func_status_check $? 

  func_print_head "Start ${component} Service"
  systemctl daemon-reload
  systemctl enable ${component} 
  systemctl start ${component}
  func_status_check $? 
}



#install Node js
func_nodejs() {
  func_print_head "Configuring Node js Repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>$log_file
  func_status_check $? 

  func_print_head "Install NodeJs"
  yum install nodejs -y   &>>$log_file
  
  func_status_check $? 
  #func_app_prereq
  func_print_head "Add Application User" 
  useradd  ${app_user}   &>>$log_file

  func_print_head "Create Application Directory"
  rm -rf /app
  mkdir /app 

  func_print_head "Download App content"  
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip    &>>$log_file
  cd /app 

  func_print_head "Unzip App content"  
  unzip /tmp/${component}.zip    &>>$log_file
  #cd /app
  
  func_print_head "Install Nodejs Dependencies"
  npm install 
  func_status_check $?  

  
  func_schema_setup
  func_systemd_setup
  

}

#install 
func_java() {
  func_print_head "Install mvn" 
  yum install maven -y   &>>$log_file

  func_status_check $?
  func_app_prereq
  

  func_print_head "Download mvn dependencies" 
  mvn clean package 
  func_status_check $?  
  mv target/${component}-1.0.jar ${component}.jar
  func_schema_setup
  func_systemd_setup

}