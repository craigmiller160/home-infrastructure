#!/bin/bash

# Imports all data necessary for the upcoming migration
# $1 = env

import_script_dir=$(dirname "${BASH_SOURCE[0]}")

IFS=$'\n'
resources=(
  "nexus_blobstore_file.npm_private npm-private"
)

function validate_arguments {
  if [ $# -lt 1 ]; then
    echo "Must specify environment"
    exit 1
  fi
}

function import {
  for r in ${resources[@]}; do
    $import_script_dir/run.sh $1 import $r
  done
}

validate_arguments $@
import $@