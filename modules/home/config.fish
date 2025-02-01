# Felix' Fish Configuration Init File.

# Fix a problem with paging on nixos, will be resolved once fish version is
# updated. https://github.com/NixOS/nixpkgs/issues/85158

set PAGER less
set LESS "-R"

function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end


function k.nodes -d "details node output"
    kubectl get nodes \
    -o=custom-columns=NodeName:.metadata.name,ROLE:.metadata.labels."kpn\.org/role",EC2-type:.metadata.labels."beta\.kubernetes\.io/instance-type",Instance-type:.metadata.labels."kpn\.org/lifecycle",AZ:.metadata.labels."topology\.kubernetes\.io/zone",IP:.metadata..annotations."alpha\.kubernetes\.io/provided-node-ip",CPU:.status.capacity.cpu,Memory:.status.capacity.memory,PODS_number:.status.capacity.pods
end

function k.nodes.ingress -d "details node output"
    kubectl get nodes --selector=kpn.org/role=ingress  \
    -o=custom-columns=NodeName:.metadata.name,ROLE:.metadata.labels."kpn\.org/role",EC2-type:.metadata.labels."beta\.kubernetes\.io/instance-type",Instance-type:.metadata.labels."kpn\.org/lifecycle",AZ:.metadata.labels."topology\.kubernetes\.io/zone",IP:.metadata..annotations."alpha\.kubernetes\.io/provided-node-ip",CPU:.status.capacity.cpu,Memory:.status.capacity.memory,PODS_number:.status.capacity.pods
end

function k.nodes.gpu -d "details node output"
    kubectl get nodes  --selector=nvidia.com/gpu=true \
    -o=custom-columns=NodeName:.metadata.name,ROLE:.metadata.labels."kpn\.org/role",EC2-type:.metadata.labels."beta\.kubernetes\.io/instance-type",Instance-type:.metadata.labels."kpn\.org/lifecycle",AZ:.metadata.labels."topology\.kubernetes\.io/zone",IP:.metadata..annotations."alpha\.kubernetes\.io/provided-node-ip",CPU:.status.capacity.cpu,Memory:.status.capacity.memory,PODS_number:.status.capacity.pods
end

function k.instanceid
  kubectl get node $argv  -o json | jq -r .spec.providerID | sed 's,.*/,,'
end


function kk
 kubectl get pods | source ~/.k8s_color  
end


function k.ec2-terminate
  kubectl drain $argv --ignore-daemonsets --delete-emptydir-data --force --timeout 5m ; 	sleep 10 ;aws ec2 terminate-instances --instance-ids "$(k.instanceid $argv)"
end

function k.ssm
  aws ssm start-session --target $(k.instanceid $argv)
end


function cws_cert_info
 echo | openssl s_client -connect $argv:443 2>/dev/null | openssl x509 -noout -subject -enddate -issuer
end

function tmux-clean
  tmux list-sessions | awk '!/^(ide|work):/ {print $1}' | sed 's/:$//' | xargs -I{} tmux kill-session -t {}
end

function bytes_to_mb_gb
    set bytes_size $argv[1]

    # Check if the argument is numeric
    if not math $bytes_size
        echo "Error: Please provide a numeric value in bytes."
        return
    end

    set mb_size (math "$bytes_size / (1024^2)")
    set gb_size (math "$bytes_size / (1024^3)")

        echo "$bytes_size bytes is equal to $gb_size GB"
        echo "$bytes_size bytes is equal to $mb_size MB"
end

function aws.ec2.list
   nu -c "aws ec2 describe-instances --query 'Reservations[].Instances[].{ID: InstanceId, IP: NetworkInterfaces[0].PrivateIpAddress, Type: InstanceType, State: State.Name, Name: Tags[?Key==`Name`]|[0].Value}' --output json | from json |select ID Name Type State IP | sort-by Name"
end
