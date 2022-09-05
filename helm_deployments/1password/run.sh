#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm_deploy.sh"
source "$run_script_dir/../../.secrets"

arguments="--set connect.operator.token.value=$onepassword_token --set connect.connect.credentials_base64=$onepassword_creds"

run 1password $@