#!/bin/bash

# Imports all data necessary for the upcoming migration
# $1 = env

import_script_dir=$(dirname "${BASH_SOURCE[0]}")

IFS=$'\n'
resources=(
  "nexus_blobstore_file.npm_private npm-private"
)

for r in ${resources[@]}; do
  $import_script_dir/run.sh $1 import $r
done