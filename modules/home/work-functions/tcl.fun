function tcl.new

    set eks_dir "/home/ubuntu/environment/aws-eks-cluster/examples/basic"
    read -l choice "Do you want to remove the Terraform state files? (y/n): "

    if string match -r "^[Yy]$" -- $choice
        cd $eks_dir
        rm -rf terraform.tfstate*
        echo "Terraform state files removed."
    else
        echo "Skipping the removal of Terraform state files."
    end

    cd $eks_dir
    set -x TF_VAR_random_cluster_name_suffix (tr -dc "[:alnum:]" </dev/urandom | head -c 4 | tr "[:upper:]" "[:lower:]")
    terraform init --upgrade && terraform apply -auto-approve
end
