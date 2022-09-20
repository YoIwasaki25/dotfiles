#set -Ux TERM screen-256color-bce

#node
set -gx PATH $PATH "$HOME/.nodebrew/current/bin"
set -U fish_user_paths $fish_user_paths ~/.nodebrew/current/bin

set -U PATH $PATH /usr/local/cuda/bin
set -U LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/cuda/lib64

#theme
set -g thme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_use yes
set -g theme_hide_hostname yes
set -g theme_hostname always
set -g theme_display_virtualenv no

set -x GRPC_PYTHON_BUILD_SYSTEM_OPENSSL 1
set -x GRPC_PYTHON_BUILD_SYSTEM_ZLIB 1

# H2MD
set -x PATH /home/yoiwasaki/dev/h2md/h2md_1_30_5/tools/x86/ $PATH
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
if command -v pyenv 1>/dev/null 2>&1
    if status is-login && test -z "$TMUX"
        pyenv init --path fish | source
    end
    pyenv init - fish | source
    pyenv virtualenv-init - fish | source
end

command -qv nvim && alias vim nvim
set -gx EDITOR nvim

# set vim-keybindings
fish_vi_key_bindings

abbr -a lg "ls -a | grep"
abbr -a cff "cd (find . -type d | fzf)"
abbr -a off "open (find . | fzf)"
abbr -a ff "find . | fzf"
abbr -a pbcopy "clip.exe"

#peco
function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function fish_user_key_bindings
  bind /cr 'peco_select_history_order' # Ctrl + R
end

##fzf with peco
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/yoiwasaki/.pyenv/versions/anaconda3-2022.05/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

