
resource "null_resource" "fruits" {
   count = lenght(var.fruits)  

   provisioner "local-exec" { 
    command = "echo Fruit Name - $(var.fruits[count.index])"
     
   }
}

variable "fruits" {
   default = {
    apple = 100
    organa = 200
    banana = 300
   }
}