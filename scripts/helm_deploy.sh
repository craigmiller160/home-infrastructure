#!/bin/sh

# $1 = name, $2 environment, $3+ = command(s)

helm_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$helm_script_dir/variables.sh"

function get_k8s_namespace {
  case $2 in
    "dev") echo $dev_infra_namespace ;;
    "prod") echo $prod_infra_namespace ;;
    *)
      echo "Invalid environment: $2"
      exit 1
    ;;
  esac
}

function get_values_argument {
  if [ -f ./$run_script_dir/values.yml ]; then
    echo "--values ./$run_script_dir/values.yml"
  else
    echo ""
  fi
}

function uninstall {
  k8s_namespace=$(get_k8s_namespace $@)

  helm uninstall \
    $1 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace
}

function chart {
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm ${@:3} \
    $1 \
    $run_script_dir \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function validate_arguments {
  if [ $# -lt 3 ]; then
    echo "Must provide environment & helm command as arguments"
    exit 1
  fi
}

function run {
  validate_arguments $@
  case $3 in
    "uninstall") uninstall $@ ;;
    *) chart $@ ;;
  esac
}