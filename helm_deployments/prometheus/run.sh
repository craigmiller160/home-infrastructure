#!/bin/bash

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm_deploy.sh"

function run_for_namespace {
  OVERRIDE_NAMESPACE=$1
  OVERRIDE_VALUES_FILE=$2
  run ingress ${@:3}
}

OVERRIDE_NAMESPACE="prometheus"
arguments=""
run