#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/terraform.sh"
source "$run_script_dir/../../.secrets"

run $@