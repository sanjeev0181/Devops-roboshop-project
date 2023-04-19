a=10
name=Devops

#print variable
echo a= $a
echo name = ${name}


#
#Date=2023-04-18
Date= $(date +%F)
echo Today day is ${Date}

ARTH=$((2-3*4/2))
echo ARTH = ${ARTH}

#Special Variables for input
echo script Name - $0
echo first argument - $1
echo second argument - $2
echo all argument - $*
echo no .of argument- $#
