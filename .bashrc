# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

export EDITOR=vim
export BROWSER=chromium
export PS1='[\u@\h \W]\$ '
shopt -s checkwinsize
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
set -o vi

# bash history configuration
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# aliases
alias ls='ls --color=auto'
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'
alias pikaur='pikaur --noedit --noconfirm'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

forward() {
	ssh -NfL $2:localhost:$2 $1
}

vnc() (
  ssh -L 5900:localhost:5900 "$1" '/usr/bin/x11vnc -localhost -display :0' &
  pid=$!
  host=$1

  clean() {
    kill $pid
    ssh "$host" killall x11vnc
  }
  trap clean EXIT

  sleep 5
  vncviewer localhost
)

tmpd() {
	cd "$(mktemp -d)" || exit
}

json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

jsonpp() {
	for file in "$@"; do
		python -m json.tool "$file" | sponge "$file"
	done
}

remoteshark() {
	target=$1
	shift
	interface=${1:-any}
	shift

	prefix=""
	if [ ! -z "$1" ]; then
		prefix="and "
	fi

	ssh -v "$target" "tcpdump -n -i $interface -U -s0 -w - not port 22 $prefix $@"  | wireshark -k -i -
}

if [ -d /usr/share/fzf ]; then
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash
fi

if [ -d ~/.local/share/bash-completion ]; then
	for file in ~/.local/share/bash-completion/*; do
		source $file;
	done
fi

if [ "$(tty)" = "/dev/tty1" ]; then
  exec startx
	#exec sway
fi
