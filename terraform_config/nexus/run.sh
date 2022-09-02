#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/terraform.sh"
source "$run_script_dir/../../.secrets"

arguments="-var=onepassword_token=$onepassword_token -var=env=$1"

run $@