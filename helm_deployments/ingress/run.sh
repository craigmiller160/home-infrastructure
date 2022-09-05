#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm_deploy.sh"

if [ $1 != "prod" ]; then
  arguments="--set environment=$1"
else
  arguments=""
fi

function run_for_namespace {
  OVERRIDE_NAMESPACE=$1
  OVERRIDE_VALUES_FILE=$2
  run ingress ${@:3}
}

run_for_namespace "infra-$1" values.infra.yml $@