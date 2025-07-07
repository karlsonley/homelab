#!/bin/bash

# Used to get credentials to access Terraform backend using Key/ID
# Requires the Scaleway CLI to be installed and logged in
# Run with source ./set_creds.sh

mkdir -p /Users/karlsonley/.config/scw 

export AWS_ACCESS_KEY_ID=$(scw config get access-key)
export AWS_SECRET_ACCESS_KEY=$(scw config get secret-key)
