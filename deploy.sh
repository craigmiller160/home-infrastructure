#!/bin/sh

# TODO this will need to be configurable
K8S_CONTEXT=microk8s-dev

function ensure_chart_name {
  if [ $# -lt 1 ]; then
    echo "Must provide chart name"
    exit 1
  fi
}

function deploy_chart {
  if [ -f ./$1/repo.sh ]; then
    sh ./$1/repo.sh
  fi
  helm install \
    $1 \
    # TODO figure out how to derive this from directory
    1password/connect \
    --kube-context=microk8s-dev \
    --values ./$1/values.yml \
    # TODO figure out how to derive this from directory
    --set-file connect.credentials=./$1/1password_creds.json
}

ensure_chart_name $@
deploy_chart $@