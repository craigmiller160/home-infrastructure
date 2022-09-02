#!/bin/sh

# $1 = env, $2+ = command

terraform_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$terraform_script_dir/variables.sh"

function get_backend_context {
  if [ $2 == "init" ]; then
    echo "-backend-config=config_context=$k8s_context"
  else
    echo ""
  fi
}

function validate_arguments {
  if [ $# -lt 2 ]; then
    echo "Must specify environment and command to run"
    exit 1
  fi
}

function run {
  validate_arguments $@
  backend_context=$(get_backend_context $@)

  (
    cd $run_script_dir &&
    terraform ${@:2} \
      $backend_context \
      $arguments
  )
}