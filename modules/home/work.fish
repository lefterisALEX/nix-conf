# Felix' Fish Configuration Init File.

# Fix a problem with paging on nixos, will be resolved once fish version is
# updated. https://github.com/NixOS/nixpkgs/issues/85158

set PAGER less
set LESS "-R"

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
