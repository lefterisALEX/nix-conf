# Felix' Fish Configuration Init File.

# Fix a problem with paging on nixos, will be resolved once fish version is
# updated. https://github.com/NixOS/nixpkgs/issues/85158

set PAGER less
set LESS "-R"

source ./common_aliases.sh


function awaketime -d "Display time since last waking."
    echo "Awake Since " \
    (pmset -g log | awk -e '/ Wake  /{print $2}' | tail -n 1)
end


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end


function ghci-nix -d "Nix shell with haskell and packages."
    set PCKS ""
    for s in $argv
        set PCKS "$s $PCKS"
    end
    nix-shell -p "haskellPackages.ghcWithPackages (ps: with ps; [ $PCKS ])" \
    --command ghci
end
