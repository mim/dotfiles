# .bashrc

# For LISA stuff
LISARC=/u/lisa/.local.bashrc
[ -f $LISARC ] && source $LISARC

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# useful commands
alias ls='ls --color=auto'
alias ll='ls -l'
alias lll='ll'
alias lls='ls'
alias lsl='ls'
alias ec='emacsclient -n'
alias dmesg='dmesg -T'
alias today='date +%Y%m%d'
alias thes='dict -d moby-thesaurus'
alias please='sudo'
alias open='xdg-open'
alias beamerdoc='evince /usr/share/doc/texlive-doc/latex/beamer/doc/beameruserguide.pdf'

alias osu_desktop_full='rdesktop -z -u mandelm -d cse -g 2560x960 164.107.120.30'
alias osu_desktop_half='rdesktop -z -u mandelm -d cse -g 1280x960 164.107.120.30'
alias osu_desktop='rdesktop -z -u mandelm -d cse -g 1280x740 164.107.120.30'
alias osu_desktop_fs='rdesktop -z -u mandelm -d cse -f 164.107.120.30'
alias vncd='x11vnc -safer -localhost -nopw -once -display :0 -noxdamage'
alias fixSpotifyRes="sudo sed -i 's/spotify %U/spotify --force-device-scale-factor=1.8 %U/' /usr/share/applications/spotify.desktop"
alias nmr='sudo /etc/init.d/network-manager restart'

alias umrpc='unison -auto mr-pc'
alias utile='unison-2.32 -auto tile'
alias grep='grep --color=auto'

# General environment vars
#[ -n "$XAUTHORITY" ] && export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD}\007"'
#[ -n "$XAUTHORITY" ] && [ -n "$DISPLAY" ] && [ -e /home/mim/.xmodmap ] && `xmodmap /home/mim/.xmodmap`
export HISTTIMEFORMAT="%s " 
echo $PROMPT_COMMAND | grep -q history || export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'
export PS1="[\u@\h \W]$ "
export LC_COLLATE="C"
# export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
export FIGNORE='.o:.class:~'
export HISTCONTROL=ignoredups
[ -n "$XAUTHORITY" ] && xset b 0   # Turn off bell!

# Program-specific environment vars
export PATH=$HOME/code/shell:$HOME/bin:$HOME/.local/bin:$PATH
export EDITOR=/usr/bin/nano
export TEXINPUTS=".:$HOME/.tetex/:$HOME/.tetex/cleveref:$HOME/articles/sty:"
export BIBINPUTS=".:$HOME/articles/bib:"
export BSTINPUTS=".:$HOME/articles/bst:"

# HTK path on slate machines
export PATH=$PATH:/u/drspeech/opt/htk-3.4.1/x86_64/bin
export PATH=$PATH:/u/drspeech/opt/matlabR2015b/bin
export PATH=$PATH:/u/drspeech/bin

# CUDA path stuff
export CUDA_HOME=/usr/local/cuda-8.0
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


[ -f ~/.bash_secrets ] && source ~/.bash_secrets

export PYTHONPATH=$HOME/code/python:$PYTHONPATH
# export PYTHONPATH=$HOME/code/python:$HOME/share/lib/python2.5/site-packages:$PYTHONPATH

# To embed all fonts when using epstopdf and other gs programs
export GS_OPTIONS='-dEmbedAllFonts=true -dPDFSETTINGS=/prepress'
alias dvips='/usr/bin/dvips -Ppdf -G0 '
alias ps2pdf='/usr/bin/ps2pdf -dPDFSETTINGS=/printer -dUseCIEColor=true -dCompatibilityLevel=1.3 -dMaxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true '

# Propagate variables into screen sessions
# from http://lists.netisland.net/archives/plug/plug-2003-09/msg00133.html
if test -n "$WINDOW"
    then test -r ~/.display && source ~/.display
else export | egrep -- '-x (DISPLAY|XAUTHORITY)=' > ~/.display
fi
