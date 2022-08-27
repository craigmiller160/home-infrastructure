#!/bin/sh

# TODO this will need to be configurable
K8S_CONTEXT=microk8s-dev

function ensure_repos_added {
  helm repo add 1password https://1password.github.io/connect-helm-charts
}

function validate_deployment_directory {
  if [ $# -lt 1 ]; then
    echo "Must provide deployment directory"
    exit 1
  fi

  if [ ! -d $1 ]; then
    echo "Invalid deployment directory: $1"
    exit 1
  fi
}

function deploy_chart {
  source ./$1/settings.sh

  helm install \
    $1 \
    $chart_name \
    --kube-context=microk8s-dev \
    --values ./$1/values.yml \
    $arguments
}

validate_deployment_directory $@
ensure_repos_added
deploy_chart $@