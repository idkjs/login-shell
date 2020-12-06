#!/usr/bin/env fish
# set script_dir (realpath (dirname (status --current-filename)))

function is_exists
    type $argv >/dev/null 2>&1
    return $status
end

function is_osx
    test "$OSTYPE" = "darwin*"
end
# https://github.com/estrategoreal/dotfiles/blob/master/.config/fish/tmux.fish
function login-shell
    # on OS X force tmux's default command
    # to spawn a shell in the user's namespace
    # if not is_exists 'reattach-to-user-namespace'
    #     reattach-to-user-namespace -l fish
    # end
    if is_osx; and is_exists 'reattach-to-user-namespace'

        set tmux_config (cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
        tmux -f <(echo "$tmux_config") new-session; and echo "(tmux -V) created new session supported OS X"

    else
        fish
    end
end
