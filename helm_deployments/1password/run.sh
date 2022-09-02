#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm.sh"
source "$run_script_dir/../../.secrets"

run 1password $@ \
  --set connect.operator.token.value=$1password_token \
  --set connect.connect.credentials_base64=$password_creds