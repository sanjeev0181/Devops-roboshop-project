fruit_name=mango
quanity=10

if [ $fruit_name == "mango"]
then
    echo Mango Quanity - $quanity
fi

fruit_name=$1
quanity=$2

if [ "$fruit_name" == "mango"]
then
    echo Mango Quanity - $quanity
else
    echo Fruit does not exit
fi

##Alway double quote variables in expression