#!/bin/sh

# $1 = environment

helm_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$helm_script_dir/variables.sh"

function get_nexus_host {
  case $1 in
    "dev") echo $dev_nexus ;;
    "prod") echo $prod_nexus ;;
    *)
      echo "Invalid environment: $1"
      exit 1
    ;;
  esac
}

function get_tar {
  echo $(ls | grep .tar.gz)
}

function remove_tar {
  rm *.tar.gz
}

function run {
  nexus_host=$(get_nexus_host $@)

  helm package $run_script_dir

  tar_file=$(get_tar)

  curl -u -v \
    $NEXUS_USER:$NEXUS_PASSWORD
    https://$nexus_host/repository/helm-private/ \
    --upload-file $tar_file

  remove_tar
}