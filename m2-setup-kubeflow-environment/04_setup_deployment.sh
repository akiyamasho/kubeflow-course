#!/bin/bash

export KF_NAME=kf-cluster
export KF_ZONE=us-central1-a
export KF_PROJECT=mlops-experiment-sandbox
export KF_DIR=~/kf-deployments
export MGMT_NAME=kf-mgmt-cluster
export MGMTCTXT="${MGMT_NAME}"

echo "Fetching the Kubeflow package..."
mkdir -p "$KF_DIR"
kpt pkg get https://github.com/kubeflow/gcp-blueprints.git/kubeflow@v1.2.1 "${KF_DIR}"
echo "Successfully fetched the Kubeflow package"

echo "Change to the Kubeflow directory..."
cd "$KF_DIR/kubeflow" || exit
echo "Successfully changed to kubeflow directory"

echo "Fetching KubeFlow manifests..."
make get-pkg
echo "Successfully fetched KubeFlow manifests"

echo "Setting up configurations..."
kpt cfg set ./instance mgmt-ctxt "${MGMTCTXT}"
kubectl config use-context "${MGMTCTXT}"
kubectl create namespace "${KF_PROJECT}"
kubectl config set-context --current --namespace "${KF_PROJECT}"
echo "Successfully setup configurations"
echo ""
echo "You need to update the Makefile at ${KF_DIR}/kubeflow before proceeding."
echo "Follow the instructions at https://www.kubeflow.org/docs/distributions/gke/deploy/deploy-cli/#configure-kubeflow"
echo ""
