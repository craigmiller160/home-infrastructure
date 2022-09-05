#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm_deploy.sh"

if [ $1 != "prod" ]; then
  arguments="--set environment=$1"
else
  arguments=""
fi

run ingress $@