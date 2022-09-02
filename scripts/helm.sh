#!/bin/sh

# $1 = name, $2 environment, $3+ = command(s)

helm_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$helm_script_dir/variables.sh"

function get_k8s_namespace {
  case $1 in
    "dev") echo $dev_namespace ;;
    "prod") echo $prod_namespace ;;
    *)
      echo "Invalid environment: $1"
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

  heml uninstall \
    $2 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace
}

function chart {
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)

  echo $@

  helm ${@:3} \
    $1 \
    $run_script_dir \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg
    # TODO need other arguments
}

function run {
  case $3 in
    "uninstall") uninstall $@ ;;
    *) chart $@ ;;
  esac
}