resource "aws_key_pair" "example_keypair" {
  key_name   = "example-keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbBeXVe7z5C+m5V3E03bJ4QPOmT3TmeIx4ezkeZ9mAGD/BJsmRwvlq2jLwsLpzvD4VlaQYR99hS6/iZ/fZY99neVPOk0EHDeZXsHxWCJTRW5aodLT0rHbuFum/ZIitOAI8SWuoOh+7NaJU+LJiGRx2//rA/ILrLKof7owtvLEHSBfhiWuWynNTutnSBaRSmiznr3e6j5QwTG3r9Oqgm2lDCKBSpDZEJ9w4NHsEywydvPhnH77NKpVOS+d+Fd5dxfcj6X3+DxmWGFcFOpyn29OC+jYJC7xM1ibo8CuVrAdBDn8L9HjL0jgYEMJze2kek7uCbb6W/KCWaNCpla4hFQTsj3wwvCC7OZCSp7F3E3Vo8xrtFjs0SR+x51GPRjx6unffO5x4C/mgzmdMzFQWhVuGeWxRmmBf0l8xfp/mDLdgxOOrxBbE6e/7oxrCdx8N045ZEYBUEuo7Zb4bXRsLWFhzVrei7Ou9ePo7M3mBnry/WckKyK0Ir22ysWXRhb+5Qw8="
}

resource "aws_security_group" "example_security_group" {
  name_prefix = "example-sg"

  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_keypair.key_name
  #subnet_id     = "subnet-0c55b159cbfafe1f0"
  security_groups = [aws_security_group.example_security_group.name]

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