script=$(realpath "$0")
script_path=$(dirname "$script")  
source ${script_path}/common.sh

component=user
schema_setup=mango
func_nodejs


