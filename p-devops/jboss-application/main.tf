resource "aws_instance" "example_instance" {
  ami           = "ami-0d2e24a707967d0c0"
  instance_type = "t2.micro"
  key_name      = "example_keypair"
  subnet_id     = "subnet-0c55b159cbfafe1f0"

  tags = {
    Name = "example-instance"
  }
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
