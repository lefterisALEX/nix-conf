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


function k.nodes -d "details node poutput"
    kubectl get nodes \
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


function c9
asp kpn-iam ;set -x credentials (aws sts assume-role --role-arn arn:aws:iam::575484182474:role/kpn-developer --role-session-name cloud-infra --duration 28800); set -x access_key (echo $credentials | jq -r '.Credentials.AccessKeyId'); set -x secret_key (echo $credentials | jq -r '.Credentials.SecretAccessKey'); set -x session_token (echo $credentials | jq -r '.Credentials.SessionToken');
asp kpn-nonprod-techbase-containers ; aws ssm start-session --target i-0860f5365f0afe527  --document-name AWS-StartInteractiveCommand  --parameters "command='sudo -u ubuntu env AWS_ACCESS_KEY_ID=$access_key  AWS_SECRET_ACCESS_KEY=$secret_key  AWS_SESSION_TOKEN=$session_token zsh -c \"cd ~/environment/aws-eks-cluster/examples/basic/ && exec zsh\"'"
end


function c9-containers 
asp kpn-iam ;set -x credentials (aws sts assume-role --role-arn arn:aws:iam::704780718979:role/kpn-developer --role-session-name cloud-infra --duration 28800); set -x access_key (echo $credentials | jq -r '.Credentials.AccessKeyId'); set -x secret_key (echo $credentials | jq -r '.Credentials.SecretAccessKey'); set -x session_token (echo $credentials | jq -r '.Credentials.SessionToken');
asp kpn-nonprod-techbase-containers ; aws ssm start-session --target i-0860f5365f0afe527  --document-name AWS-StartInteractiveCommand  --parameters "command='sudo -u ubuntu env AWS_ACCESS_KEY_ID=$access_key  AWS_SECRET_ACCESS_KEY=$secret_key  AWS_SESSION_TOKEN=$session_token zsh -c \"cd ~/environment/aws-eks-cluster/examples/basic/ && exec zsh\"'"
end
