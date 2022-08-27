#!/bin/sh

# Script Arguments
# $1 = environment, $2 = command, $3 = deployment directory

function ensure_repos_added {
  helm repo add 1password https://1password.github.io/connect-helm-charts
  helm repo add bitnami https://charts.bitnami.com/bitnami
}

function validate_arguments {
  if [ $# -lt 3 ]; then
    echo "Must provide environment, command, and deployment directory"
    exit 1
  fi

  case $1 in
    "dev"|"prod") return 0 ;;
    *)
      echo "Invalid environment: $1"
      exit 1
    ;;
  esac

  if [ ! -d $1 ]; then
    echo "Invalid deployment directory: $1"
    exit 1
  fi
}

function get_k8s_context {
  case $1 in
    "dev") echo "microk8s-dev" ;;
    "prod") echo "microk8s-prod" ;;
  esac
}

function install_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)

  helm install \
    $3 \
    $chart_name \
    --kube-context=$k8s_context \
    --values ./$3/values.yml \
    $arguments
}

function upgrade_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)

  helm upgrade \
    $3 \
    $chart_name \
    --kube-context=$k8s_context \
    --values ./$3/values.yml \
    $arguments
}

function uninstall_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)

  helm uninstall \
    $3 \
    --kube-context=$k8s_context
}

function run_chart_command {
  case $2 in
    "install") install_chart $@ ;;
    "upgrade") upgrade_chart $@ ;;
    "uninstall") uninstall_chart $@ ;;
    *)
      echo "Invalid chart command: $2"
      exit 1
    ;;
  esac
}

validate_arguments $@
ensure_repos_added $@
run_chart_command $@