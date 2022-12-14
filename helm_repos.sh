#!/bin/sh

function ensure_repos_added {
  helm repo add 1password https://1password.github.io/connect-helm-charts
#  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add jetstack https://charts.jetstack.io
#  helm repo add dev_nexus https://dev-nexus-craigmiller160.ddns.net/repository/helm-private
  helm repo add prod_nexus https://nexus-craigmiller160.ddns.net/repository/helm-private
  helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
}

ensure_repos_added