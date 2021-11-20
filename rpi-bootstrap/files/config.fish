
# Fish usage: https://fishshell.com/docs/current/cmds/bind.html

############
# VIM MODE #
############

set -g fish_key_bindings fish_vi_key_bindings
bind -M insert \cc kill-whole-line repaint

#############
# !! AND !$ #
#############

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

########
# HSTR #
########

alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
export HISTCONTROL=ignorespace   # leading space hides commands from history
bind \cr 'hstr'

###########
# STARTUP #
###########

echo; neofetch
