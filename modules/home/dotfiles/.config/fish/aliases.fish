alias l 'exa -la -s changed'
alias kpn 'vpnkpn start'
alias vbox-local-dev "VBoxManage  startvm ubuntu-server --type headless"
alias vbox-cloudinfra "VBoxManage  startvm ubuntu-cloudinfra --type headless"
alias vbox-sandbox "VBoxManage  startvm sandbox --type headless"
alias vbox-nix "VBoxManage  startvm nixos --type headless"
alias vbox-ubuntu-nix "VBoxManage  startvm ubuntu-with-nix --type headless"
alias vbox-off "VBoxManage  controlvm ubuntu-server poweroff ||  VBoxManage  controlvm sandbox  poweroff"
alias dot "/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME"
alias vi "nvim"
alias eks "cd /Users/lefteris/repos/techbase/aws-eks-cluster/ ; nvim ."

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias bt 'bat --paging=never'

# git
alias gd  'git diff'
alias ga 'git add'
alias gp 'git push' 
alias lg 'lazygit'
alias ggpush  'git push origin $(current_branch)'
alias grbiom  'git rebase --interactive origin/master'
alias g.log1  "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all" 

# kubectl
alias k 'kubectl'
alias kg 'k get pods'
alias kx 'kubie ctx'
alias kn 'kubie ns'
alias ksys 'kubens kube-system'
alias display_home_living_room 'displayplacer "id:9C41E733-6867-C951-A677-DFCF396700DC res:2560x1080 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:697A0535-F79C-6A9F-6E01-132B260BBA81 res:1792x1120 hz:59 color_depth:8 scaling:on origin:(2560,640) degree:0"'
#alias ks 'kubectl --namespace=kube-system'


# pods
alias kg.pods.prometheus 'kubectl get pods -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -owide -n kube-system'
alias kg.pods.splunk 'kubectl get pods -l app=splunk-collector -owide -n kube-system'
#port-forward
alias k.pf.alermanager 'kubectl -n kube-system port-forward svc/kube-prometheus-stack-alertmanager 9093:9093'
alias k.pf.prometheus 'kubectl -n kube-system port-forward svc/kube-prometheus-stack-prometheus 9090:9090'
alias k.pf.hubble-relay 'kubectl -n kube-system port-forward svc/hubble-relay 4245:80'

#cloud9
alias c9_start 'asp kpn-nonprod-techbase-containers ; aws ec2 start-instances --instance-ids i-0860f5365f0afe527'
alias load_runner_start 'asp kpn-nonprod-techbase-containers ; aws ec2 start-instances --instance-ids i-0d09f9221dc91b2f3'
alias load_runner_stop 'asp kpn-nonprod-techbase-containers ; aws ec2 stop-instances --instance-ids i-0d09f9221dc91b2f3'
alias load_runner 'asp kpn-nonprod-techbase-containers ; aws ssm start-session --target i-0d09f9221dc91b2f3'

