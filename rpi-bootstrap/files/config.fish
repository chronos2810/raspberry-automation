
# Fish usage: https://fishshell.com/docs/current/cmds/bind.html

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

#######
# FZF #
#######

fzf_key_bindings

###########
# STARTUP #
###########

echo; neofetch
