#!/bin/sh

# Script Arguments
# $1 = environment, $2 = deployment directory, $3 = command

function ensure_repos_added {
  helm repo add 1password https://1password.github.io/connect-helm-charts
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add jetstack https://charts.jetstack.io
}

function validate_arguments {
  if [ $# -lt 3 ]; then
    echo "Must provide environment, deployment directory, and command"
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
  # TODO need to rename my cluster contexts
  echo "microk8s-prod"
}

function get_k8s_namespace {
  case $1 in
    "dev") echo "infra-dev" ;;
    "prod") echo "infra-prod" ;;
  esac
}

function get_values_argument {
  if [ -f ./$2/values.yml ]; then
    echo "--values ./$2/values.yml"
  else
    echo ""
  fi
}

function get_settings {
  if [ -f ./$2/settings.sh ]; then
    source ./$2/settings.sh
  fi
}

function install_chart {
  get_settings $@
  k8s_context=$(get_k8s_context $@)
  k8s_namespace=$(get_k8s_namespace $@)
  values_arg=$(get_values_argument $@)

  helm install \
    $2 \
    $2 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function template_chart {
  get_settings $@
  k8s_context=$(get_k8s_context $@)
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm template \
    $2 \
    $2 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function upgrade_chart {
  get_settings $@
  k8s_context=$(get_k8s_context $@)
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm upgrade \
    $2 \
    $2 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function uninstall_chart {
  get_settings $@
  k8s_context=$(get_k8s_context $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm uninstall \
    $2 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace
}

function run_chart_command {
  case $3 in
    "install") install_chart $@ ;;
    "upgrade") upgrade_chart $@ ;;
    "uninstall") uninstall_chart $@ ;;
    "template") template_chart $@ ;;
    *)
      echo "Invalid chart command: $3"
      exit 1
    ;;
  esac
}

validate_arguments $@
ensure_repos_added $@
run_chart_command $@