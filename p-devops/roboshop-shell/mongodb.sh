cp mongo.repo  /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y 

systemctl enable mongod 
systemctl start mongod 

# edit the file and replace 127.0.0.0 to 0.0.0.0
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
