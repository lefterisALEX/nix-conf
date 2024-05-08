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

function tcloud.acc
  echo tcloud-acc1
  echo tcloud-de-acc1
  echo tcloud-itv-acc1
  echo tcloud-monitoring-np
end


function tcloud.dev
  echo tcloud-dev1
  echo tcloud-de-dev1
  echo tcloud-itv-dev1
end


function tcloud.ingress.status.acc
  for i in $(tcloud.acc)
  kubie exec $i  ingress-nginx  kubectl get pods -owide
 end
end


function tcloud.ingress.status.all
 for i in $(tcloud.dev)
  kubie exec $i  ingress-nginx  kubectl get pods  -owide
 end
  for i in $(tcloud.acc)
  kubie exec $i  ingress-nginx  kubectl get pods -owide
 end
  for i in $(tcloud.prod)
  kubie exec $i  ingress-nginx  kubectl get pods -owide
 end
end


function tcloud.ingress.status.dev
 for i in $(tcloud.dev)
  kubie exec $i  ingress-nginx  kubectl get pods  -owide
 end
end


function tcloud.list.namespaced.resources
 kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 -I {} kubectl get -n $argv {} --no-headers -o custom-columns="RESOURCE:metadata.name,KIND:.kind"
end


function tcloud.notrunningpods.count.prod
 kubie exec tcloud-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed |wc -l
 kubie exec tcloud-de-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed |wc -l
 kubie exec tcloud-itv-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed |wc -l
 kubie exec tcloud-tools-prd kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed | wc -l
end


function tcloud.notRunningPods.Prod
 kubie exec tcloud-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed 
 kubie exec tcloud-de-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed
 kubie exec tcloud-itv-prd1 kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed
 kubie exec tcloud-tools-prd kube-system kubectl get pods -A -owide |grep -v Running |grep -v Completed
end

function tcloud.prod
echo tcloud-prd1
echo tcloud-de-prd1
echo tcloud-itv-prd1
echo tcloud-tools-prd
echo tcloud-rancher-prd
echo tcloud-monitoring
end


function tcloud.prometheus.status.all-prod
 kubie exec tcloud-prd1 kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
 kubie exec tcloud-de-prd1 kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
 kubie exec tcloud-itv-prd1 kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
end


function tcloud.prometheus.status.all
 for i in $(tcloud.dev)
  kubie exec $i  kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
 end
  for i in $(tcloud.acc)
  kubie exec $i  kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
 end
  for i in $(tcloud.prod)
  kubie exec $i  kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
 end
endfunction tcloud.prometheus.status
 kubie exec $argv kube-system  kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide
end


function tcloud.prometheus.top.all-prod
 kubie exec tcloud-prd1 kube-system  kubectl top pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus
 kubie exec tcloud-de-prd1 kube-system  kubectl top pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus
 kubie exec tcloud-itv-prd1 kube-system  kubectl top pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus
end


function tcloud.prometheus.top
 kubie exec $argv kube-system  kubectl top pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus
end
