export PATH="/usr/local/bin:$PATH" export PATH=$PATH:~/.cache/sourcekit-lsp/.build/release/
export PATH=$PATH:~/.nodebrew/current/bin
export PATH=$PATH:~/flutter/bin
export PATH=$PATH:~/.pyenv/versions/anaconda3-5.3.1/bin


eval "$(pyenv init -)"

# vimライクな操作方法
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

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

#起動と同時にtmuxを起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

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

