#!/bin/sh

# $1 = env, $2 = directory, $3 = command

k8s_context="microk8s-prod"

function get_backend_context {
  if [ $3 == "init" ]; then
    echo "-backend-config=config_context=$k8s_context"
  else
    echo ""
  fi
}

(
  cd "$2" &&
  terraform ${@:3} \
    get_backend_context $@
)