data "aws_security_group" "selected" {
    name="allows_tls"
}


resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "ajith_keys"
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = "example-instance"
  }

  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "password"
  }

  provisioner "remote-exec" {
    inline = [
      "Invoke-WebRequest https://download.jboss.org/wildfly/22.0.1.Final/wildfly-22.0.1.Final.zip -OutFile C:/wildfly-22.0.1.Final.zip",
      "Expand-Archive C:/wildfly-22.0.1.Final.zip -DestinationPath C:/",
      "Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment' -Name JAVA_HOME -Value 'C:\\Program Files\\Java\\jdk1.8.0_291'",
      "Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment' -Name JBOSS_HOME -Value 'C:\\wildfly-22.0.1.Final'",
      "Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment' -Name PATH -Value $env:PATH+';C:\\wildfly-22.0.1.Final\\bin'"
    ]
  }

#   provisioner "file" {
#     source      = "path/to/your/app.war"
#     destination = "C:/wildfly-22.0.1.Final/standalone/deployments/app.war"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "C:/wildfly-22.0.1.Final/bin/standalone.bat -c standalone-full.xml"
#     ]
#   }
}
