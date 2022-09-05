#!/bin/sh

# $1 = SOMETHING, $2 = environment

helm_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$helm_script_dir/variables.sh"

function get_nexus_host {
  case $2 in
    "dev") echo $dev_nexus ;;
    "prod") echo $prod_nexus ;;
    *)
      echo "Invalid environment: $2"
      exit 1
    ;;
  esac
}

