
resource "null_resource" "fruits" {
   #count = length(var.fruits)  
   for_each = var.fruits

   provisioner "local-exec" { 
    #command = "echo Fruit Name - $(var.fruits[count.index])"
    #command = "echo ${length(var.fruits)}"
    command = "echo Fruit Name - ${each.key} - ${each.value}"
     
   }
}

variable "fruits" {
   default = {
    apple = 100
    organa = 200
    banana = 300     
   }
}