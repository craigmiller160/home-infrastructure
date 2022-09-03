#!/bin/bash

# Imports all data necessary for the upcoming migration
# $1 = env

import_script_dir=$(dirname "${BASH_SOURCE[0]}")

IFS=$'\n'
resources=(
  "nexus_blobstore_file.npm_private npm-private"
  "nexus_blobstore_file.npm_proxy npm-proxy"
  "nexus_blobstore_file.npm_group npm-group"
  "nexus_blobstore_file.docker_private docker-private"
  "nexus_blobstore_file.docker_proxy docker-proxy"
  "nexus_blobstore_file.docker_group docker-group"
  "nexus_repository_npm_hosted.npm_private npm-private"
  "nexus_repository_npm_proxy.npm_proxy npm-proxy"
  "nexus_repository_npm_group.npm_group npm-group"
  "nexus_repository_docker_hosted.docker_private docker-private"
  "nexus_repository_docker_proxy.docker_proxy docker-proxy"
  "nexus_repository_docker_group.docker_group docker-group"
  "nexus_security_user.craigmiller160 craigmiller160"
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
    if [ $? -ne 0 ]; then
      exit 1
    fi
  done
}

validate_arguments $@
import $@