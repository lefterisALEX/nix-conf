set -g tide_left_prompt_frame_enabled true 
set -g tide_left_prompt_items  pwd git newline
set -g tide_right_prompt_items status kubectl cmd_duration aws 
set -g tide_kubectl_bg_color 326CE5
set -g tide_kubectl_color ffff00
set -g fish_prompt_pwd_dir_length 2 
set -g tide_prompt_min_cols 2
set -g tide_pwd_bg_color 20252c
set -gx PATH $PATH $HOME/.krew/bi
 


if status is-interactive
     abbr --add --global kw 'k.watch'
     abbr --add --global g.log "git log --pretty=format:'%C(yellow)%h %<(24)%C(red)%ad %<(18)%C(green)%an %C(reset)%s' --date=local --max-count=10"
     abbr --add --global ks 'kubectl --namespace=kube-system'
     abbr --add --global kc 'kubectl --namespace=cattle-system'
     abbr --add --global ki 'kubectl --namespace=ingress-nginx'
     abbr --add --global k.nodes.tcloud-dev 'kubie exec tcloud-dev default kubectl get nodes'
     abbr --add --global k.nodes.tcloud-acc 'kubie exec tcloud-acc1 default kubectl get nodes'
     abbr --add --global k.nodes.tcloud-dev 'kubie exec tcloud-dev default kubectl get nodes'
     abbr --add --global k.nodes.tcloud-dev 'kubie exec tcloud-dev default kubectl get nodes'
     abbr --add --global k.nodes.tcloud-dev 'kubie exec tcloud-dev default kubectl get nodes'
     abbr --add --global k.events "kubectl get events --sort-by='.metadata.creationTimestamp'"
     abbr --add --global k.nodes.gpu "kubectl get nodes  --selector=nvidia.com/gpu=true"
     abbr --add --global k.nodes.ingress "kubectl get nodes  --selector=kpn.org/role=ingress"
     abbr --add --global k.nodes.taints "kubectl get nodes -o=custom-columns=NodeName:.metadata.name,TaintKey:.spec.taints[].key,TaintValue:.spec.taints[].value,TaintEffect:.spec.taints[].effect"
     abbr --add --global k.nodes.taints2 "kubectl get nodes -o=custom-columns=NodeName:.metadata.name,TaintKey:.spec.taints"
     abbr --add --global k.nodes 'kubectl get nodes -o=custom-columns=NodeName:.metadata.name,ROLE:.metadata.labels."kpn\.org/role",EC2-type:.metadata.labels."beta\.kubernetes\.io/instance-type",Instance-type:.metadata.labels."kpn\.org/lifecycle",AZ:.metadata.labels."topology\.kubernetes\.io/zone",IP:.metadata..annotations."alpha\.kubernetes\.io/provided-node-ip",CPU:.status.capacity.cpu,Memory:.status.capacity.memory,PODS_number:.status.capacity.pods'
     abbr --add --global k.rancher.clusters 'kubectl get cluster.fleet -n fleet-default -o=custom-columns=ClusterName:.metadata.labels."management\.cattle\.io/cluster-display-name",ClusterID:.metadata.labels."management\.cattle\.io/cluster-name"'
     abbr --add --global k.rancher.fleet 'kubectl get cluster.fleet -n fleet-default'
     abbr --add --global k.rancher.users 'kubectl get users.management.cattle.io -o=custom-columns=UserName:.displayName,UserID:.metadata.name'
     abbr --add --global k.rancher.status 'kubectl get cluster -n fleet-default'
     abbr --add --global k.rancher.projects 'kubectl get projects.management.cattle.io -o=custom-columns=ProjectName:.spec.displayName,ProjectID:.metadata.name' ## need to change to namespace of the cluster
     abbr --add --global k.rancher.list-namespaces-of-project-name 'kubectl get ns --selector=kubernetes.io/metadata.name=de-nbiot-sales-tst'
     abbr --add --global k.rancher.list-namespaces-of-project-id 'kubectl get namespaces --selector=field.cattle.io\/projectId=p-9skxk'
     abbr --add --global k.pods.controllers 'kubectl get pods -o custom-columns=NAME:.metadata.name,CONTROLLER:.metadata.ownerReferences[].kind,NAMESPACE:.metadata.namespace'
     abbr --add --global k.nodes.label "kubectl get no -o json | jq '.items[].metadata.labels'"
     abbr --add --global k.namespace.list_only_ns_with_pss_label "kubectl get ns -o json | jq '[.items[].metadata.labels | select(.[\"kubernetes.io/metadata.name\"] and .[\"pod-security.kubernetes.io/enforce\"])]'"
     abbr --add --global k.namespace.list_all_ns_and_pss_label "kubectl get ns -o json | jq '[.items[].metadata.labels | { \"kubernetes.io/metadata.name\", \"pod-security.kubernetes.io/enforce\" }]'"

end

. ~/.config/fish/aliases.fish
