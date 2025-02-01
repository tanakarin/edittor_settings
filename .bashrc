# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# User specific environment
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prepost,interactiveに何分いたか表示
SHELL_START_TIME=$(date +%s)
elapse_time() {
    local NOW=$(date +%s)
    local ELAPSED=$(( NOW - SHELL_START_TIME))
    printf '%02d:%02d' $(( (ELAPSED % 3600) / 60 )) $(( ELAPSED % 60 ))
}
export PS1="\[\e[1;32m\]login@\[\e[m\]\[\e[1;33m\]\w\[\e[m\]\[\e[0;37;44m\]\$(parse_git_branch)\[\033[00m\] $ "
if [ ${HOSTNAME} = "wa01" ] || [ ${HOSTNAME} = "wa02" ]; then
    export PS1="\[\033[00m\][\$(elapse_time)]\[\e[1;37m\]interactive@\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[0;37;44m\]\$(parse_git_branch)\[\033[00m\] $ "
elif [ ${HOSTNAME} = "wisteria10" ] || [ ${HOSTNAME} = "wisteria11" ]; then
    export PS1="\[\033[00m\][\$(elapse_time)]\[\e[1;37m\]prepost@\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[0;37;44m\]\$(parse_git_branch)\[\033[00m\] $ "
fi

PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias ls='ls -F --color -v --group-directories-first -h -p -x'
alias lv='less -c'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export EDITOR=vim

# 関数定義
## ファイルの数
filenum()
{
    local printedword=$(find $1 -xtype f -print | wc -l)
    echo "file num is $printedword"
    local printedword=$(find $1 -xtype d -print | wc -l)
    echo "directory num is $printedword"
}

## ディレクトリ削除
del()
{
    cp -r $@ $GOMI_BOX
    mv --force $@ $GOMI_BOX
}

gomibox_delete_all()
{
    local strrr
    read -p "Are you sure to delete gomibox?(y/n) > "  strrr
    if [ "$strrr" == "y" ]; then
        rm -rf ${GOMI_BOX}/*
    fi
}

## インタラクティブシェルに入る
pjinter()
{
        mkdir -p /work/group_name/username/gomi_box
    pjsub --interact -L rscgrp=interactive-a,node=1,jobenv=singularity -g group_name -o /work/group_name/username/gomi_box/std.out -e /work/group_name/username/gomi_box/std.err --mpi proc=8 --sparam wait-time=600
}

# プリポストシェルに入る
prepost()
{
    pjsub --interact -g group_name -L rscgrp=prepost,jobenv=singularity -o /work/group_name/username/gomi_box/std.out -e /work/group_name/username/gomi_box/std.err
}


# インタラクティブジョブに入ったらload env
if [ -e LOAD_ENV ] && ( [ ${HOSTNAME} = "wa01" ] || [ ${HOSTNAME} = "wa02" ] );then
    source LOAD_ENV
fi

shopt -s direxpand
shopt -s autocd
