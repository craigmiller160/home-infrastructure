#!/bin/bash

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm_deploy.sh"
source "$run_script_dir/../../.secrets"

OVERRIDE_NAMESPACE="prometheus"
arguments="--set kube-prometheus-stack.grafana.adminPassword=$grafana_admin_password"
run prometheus "x" $1