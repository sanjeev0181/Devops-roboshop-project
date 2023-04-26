variable "sample_string" {
    default = "Hello World"
}

## Shell Scripting equivalent sample_string="Hello World"

variable "sample_number" {
  default = 100
}
#10.6 is also a number in terraform


variable "sample_boolean" {
  default = true
}

## Boolean are true or false
## Boolean and number does not need to the quoted, only strings need to be qoutes that to be 
## with double quotes. terraform does  support for single quotes .


### Variable Types
# So far we have seen is default variable type

# we have list variable type , Meaning single variable can hold multiple values.

variable "sample_list" {
    default = [100,"hello",true,123]
}

## Data type inside the list does not matter in terraform

# We have a directory ( or map ),meaning single variable will have multiple values, & each value going to have 
# sperate name.

variable "sample_dict" {
    default = { number1 = 100, string = "hello", number2 = 123 , boolean = true}
}

## This is the most preferred variable over the list when we declare the data.


  
variable "env" {}