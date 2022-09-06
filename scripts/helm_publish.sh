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
  echo $(ls | grep .tgz)
}

function remove_tar {
  rm *.tgz
}

function run {
  nexus_host=$(get_nexus_host $@)

  helm package $run_script_dir

  tar_file=$(get_tar)

  curl -v \
    -u $NEXUS_USER:$NEXUS_PASSWORD \
    https://$nexus_host/repository/helm-private/ \
    --upload-file $tar_file

  remove_tar
}