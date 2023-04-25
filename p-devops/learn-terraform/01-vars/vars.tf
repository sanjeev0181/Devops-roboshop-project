variable "sample_string" {
    default = "Hello World"
}

## Shell Scripting equivalent sample_string="Hello World"

# To print in shell script we use echo following is the syntax in shell
# echo $sample_string
output "sample_string" {
  value = var.sample_string 
}

## In above case we are printing just variable, If variable is a combination of some string then following is the syntax.

output "sample_string1" {
  value = "Value of sample_string = ${var.sample_string}" 
}