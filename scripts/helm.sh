#!/bin/sh

# $1 = environment, $2+ = command(s)

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
    "" \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace
}

function chart {
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)
}

function run {
  case $2 in
    "uninstall") uninstall $@ ;;
    *) chart $@ ;;
  esac
}