# IMPORTANT - The paths must be relative paths because that is how they were first written, and making them absolute paths breaks
# the existing data configuration in Nexus

resource "nexus_blobstore_file" "npm_private" {
  name = "npm-private"
  path = "npm-private"
}

resource "nexus_blobstore_file" "npm_proxy" {
  name = "npm-proxy"
  path = "npm-proxy"
}

resource "nexus_blobstore_file" "npm_group" {
  name = "npm-group"
  path = "npm-group"
}

resource "nexus_blobstore_file" "docker_private" {
  name = "docker-private"
  path = "docker-private"
}

resource "nexus_blobstore_file" "docker_proxy" {
  name = "docker-proxy"
  path = "docker-proxy"
}

resource "nexus_blobstore_file" "docker_group" {
  name = "docker-group"
  path = "docker-group"
}

resource "nexus_blobstore_file" "helm_private" {
  name = "helm-private"
  path = "helm-private"
}