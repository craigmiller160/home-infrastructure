#!/bin/sh

# Script Arguments
# $1 = environment, $2 = command, $3 = deployment directory

function ensure_repos_added {
  helm repo add 1password https://1password.github.io/connect-helm-charts
  helm repo add bitnami https://charts.bitnami.com/bitnami
}

function ensure_cluster_setup {
  kubectl apply -f ./k8s_setup/namespaces.yml
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
  if [ -f ./$3/values.yml ]; then
    echo "--values ./$3/values.yml"
  else
    echo ""
  fi
}

function install_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)
  k8s_namespace=$(get_k8s_namespace $@)
  values_arg=$(get_values_argument $@)

  helm install \
    $3 \
    $chart_name \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function upgrade_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)
  values_arg=$(get_values_argument $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm upgrade \
    $3 \
    $chart_name \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
    $values_arg \
    $arguments
}

function uninstall_chart {
  source ./$3/settings.sh
  k8s_context=$(get_k8s_context $@)
  k8s_namespace=$(get_k8s_namespace $@)

  helm uninstall \
    $3 \
    --kube-context=$k8s_context \
    --namespace $k8s_namespace \
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
ensure_cluster_setup $@
ensure_repos_added $@
run_chart_command $@