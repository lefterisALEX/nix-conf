#!/bin/bash

tcl.new() {
    eks_dir="/home/lefteris/repos/aws-eks-cluster/examples/basic"

    # Correctly prompting for input using read -p
    read -p "Do you want to remove the Terraform state files? (y/n): " choice

    if [[ $choice =~ ^[Yy]$ ]]; then
        cd "${eks_dir}" || return  # Safe cd with error handling
        rm -rf terraform.tfstate*
        echo "Terraform state files removed."
    else
        echo "Skipping the removal of Terraform state files."
    fi

    cd "${eks_dir}" || return  # Safe cd with error handling
    export TF_VAR_random_cluster_name_suffix=$(tr -dc "[:alnum:]" </dev/urandom | head -c 4 | tr "[:upper:]" "[:lower:]")
    terraform init --upgrade && terraform apply -auto-approve
}

