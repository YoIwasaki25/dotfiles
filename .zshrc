export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:"$GOPATH/bin"

export XDG_CONFIG_HOME=$HOME/.config
export ANYENV_ROOT=$HOME/.anyenv

export DOWNLOADS=$HOME/Downloads
export LOCALWORK=$HOME/localwork
export OFFICE=$HOME/localwork/office
export PHOTOSHOP=$HOME/localwork/photoshop
export PROJECT=$HOME/localwork/project
export TEMP=$HOME/localwork/temp
export MINUTES=$HOME/minutes
export REFERENCE=$PROJECT/Cygames/reference
#GOPATH以外でも補完が効くようにする。
# export G0111MODULE=on

eval "$(anyenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(goenv init -)"

# vimライクな操作方法
bindkey -v
# bindkey -M viins 'jj' vi-cmd-mode
#ヤンクしたものをクリップボードに貼り付ける
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy -i
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

function paste-as-yank {
    pbpaste
}
zle -N paste-as-yank
bindkey -M vicmd 'p' paste-as-yank
# 入力コマンドが存在しない場合cdを使わず移動する
setopt auto_cd

# cd + <Tab> でディレクトリの履歴が表示される
setopt auto_pushd
setopt PUSHD_IGNORE_DUPS

# cdなしで、2つ3つ上のディレクトリに戻る
alias ...='cd ../..'
alias ....='cd ../../..'
alias vim='nvim' 
# clasp
alias push="clasp push"
alias run="clasp run"
alias logs="clasp logs"
alias grep="ls -a | grep"
#大文字小文字を無視して補完する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#補完機能をタブとエンターとカーソルを有効にする
autoload -U compinit
compinit 
zstyle ':completion:*:default' menu select=1
 #h補完候補に色を付ける
autoload -U colors
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"

# 括弧の対応
setopt auto_param_keys

# ファイル名の展開でディレクトリにマッチした場合　末尾に/ を付加
setopt mark_dirs

# コマンドラインすべてのスペルチェックをする
setopt correct_all

# 他のターミナルとヒストリーを共有
setopt share_history
setopt hist_ignore_all_dups

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt inc_append_history
#ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

#起動と同時にtmuxを起動
# [[ -z "$TMUX" && ! -z "$PS1" ]] && tmux -u

### Added by Zinit's installer
if [[ ! -f $HOME/.zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zsh/.zinit" && command chmod g-rwX "$HOME/.zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# oh-my-zshのセットアップ
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git # <- なんかおまじないらしい
zinit cdclear -q

# プロンプトのカスタマイズ
setopt promptsubst
zinit snippet OMZT::gnzh

#plugins
zinit light sindresorhus/pure
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word

