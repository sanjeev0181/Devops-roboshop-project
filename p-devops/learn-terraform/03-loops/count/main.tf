resource "null_resource" "null" {
    count = 20
}

resource "null_resource" "fruits" {
   count = lenght(var.fruits)  

   provisioner "local-exec" { 
    command = "echo Fruit Name - $(var.fruits[count.index])"
     
   }
}

variable "fruits" {
    default  = ["apply","banana","organa"]  
    description = "(optional) describe your variable"
}