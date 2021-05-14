#!/bin/bash

gcloud auth login
# create application default credentials : done once
gcloud auth application-default login
# GCP Project ID
export PROJECT=mlops-experiment-sandbox
gcloud config set project ${PROJECT}
# GCP Zone
export ZONE=us-central-1
gcloud config set compute/zone ${ZONE}
