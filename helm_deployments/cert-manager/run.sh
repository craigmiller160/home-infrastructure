#!/bin/sh

run_script_dir=$(dirname "${BASH_SOURCE[0]}")
source "$run_script_dir/../../scripts/helm.sh"

arguments="--set cert-manager.installCRDs=true"

run cert-manager $@