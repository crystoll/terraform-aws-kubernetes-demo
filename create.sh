#!/bin/bash

#- Downloading plugin for provider "aws" (2.5.0)...
(cd terraform && terraform init) || exit 1

(cd terraform && terraform plan -out terraform.plan) || exit 1

(cd terraform && terraform apply -auto-approve terraform.plan) || exit 1


