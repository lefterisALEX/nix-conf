alias k='kubectl'
alias c='clear'
alias kx='kubie ctx'
alias kn='kubie ns'
alias g.log="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gl="git log --pretty=format:'%C(yellow)%h %<(24)%C(red)%ad %<(18)%C(green)%an %C(reset)%s' --date=local --max-count=10"
#port-forward
alias k.pf.alermanager 'kubectl -n kube-system port-forward svc/kube-prometheus-stack-alertmanager 9093:9093'
alias k.pf.prometheus 'kubectl -n kube-system port-forward svc/kube-prometheus-stack-prometheus 9090:9090'
alias k.pf.hubble-relay 'kubectl -n kube-system port-forward svc/hubble-relay 4245:80'
