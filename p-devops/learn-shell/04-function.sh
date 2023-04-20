# A name give to set of commands is called as function.



#Declare a function
function_name() {
    echo Hello World
}

#call function
function_name

#we can send inputs to the function and we can access them special varaibles $1-$n,$*,$#.

function_name1() {
    echo first argument - $1
    echo second argument - $2
    echo all argument - $*
    echo no .of argument- $#
}

function_name1 123 xyz