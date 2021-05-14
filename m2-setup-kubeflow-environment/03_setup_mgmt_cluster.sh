#!/bin/bash

export MGMT_PROJECT=mlops-experiment-sandbox
export MGMT_DIR=~/kf-deployments
export MGMT_NAME=kf-mgmt-cluster
export LOCATION=us-central1-a

echo "Fetching the management blueprint to current directory..."
mkdir -p "${MGMT_DIR}"
kpt pkg get https://github.com/kubeflow/gcp-blueprints.git/management@v1.2.0 "${MGMT_DIR}"
echo "Successfully fetched the management blueprint to current directory"

echo "Fetch the upstream management package..."
cd "${MGMT_DIR}/management" || exit 1
make get-pkg
echo "Successfully fetched the upstream management package"

echo "Setting values for the name, project, and location of your management cluster..."
kpt cfg set -R . name "${MGMT_NAME}"
kpt cfg set -R . gcloud.core.project "${MGMT_PROJECT}"
kpt cfg set -R . location "${LOCATION}"
echo "Successfully set values for kpt"

echo "Applying the management cluster.."
make apply-cluster
echo "Successfully applied management cluster"

echo "Creating kubectl context for the management cluster"
make create-context
echo "Successfully created kubectl context for the management cluster"

echo "Installing the Cloud Config Connector"
make apply-kcc
echo "Successfully installed the Cloud Config Connector"
