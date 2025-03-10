# ~/.bashrc for bash interactive shells.

# Change directory just by typing its name
shopt -s autocd

# Allow comments in interactive mode
shopt -s interactive_comments

# Ignore errors if no match for a pattern
shopt -s nullglob

# Enable command substitution in prompt
shopt -s promptvars

# Sort filenames numerically
shopt -s checkwinsize

# History configurations
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=2000

# Delete duplicates first when HISTFILE size exceeds HISTSIZE
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Show command before executing when using history expansion
shopt -s histverify

# Alias pour afficher tout l'historique
alias history="history 0"


# Configurer le prompt (PS1)
PROMPT_COMMAND=set_bash_prompt

set_bash_prompt() {
    local prompt_symbol="@"
    
    # D├®tecter si l'utilisateur est root
    if [ "1000" -eq 0 ]; then
        # root en rouge
        user_host="\[\033[1;31m\](\u\h)\[\033[0m\]"
    else
        # Nom d'utilisateur en bleu
        user_host="\[\033[1;34m\](\u\h)\[\033[0m\]"
    fi
    
    # Afficher le groupe de l'utilisateur
    local group="\[\033[1;32m\]$(id -gn)\[\033[0m\]"  # Affiche ton groupe
    local path="\[\033[1;32m\]\w\[\033[0m\]"  # Affiche le r├®pertoire courant
    local git_info="$(git_prompt)"  # Affiche le statut Git si dans un d├®p├┤t
    local venv_info="$(venv_prompt)"  # Affiche l'environnement virtuel actif si pr├®sent
    local prompt_end="\[\033[1;36m\]$\[\033[0m\]"

    # Ajouter l'information de venv avant le nom d'utilisateur et chemin
    PS1="\nÔöîÔöÇÔöÇ-[]\nÔööÔöÇ "
}

# Fonction pour afficher le statut Git
git_prompt() {
    # V├®rifier si un d├®p├┤t git est pr├®sent
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        branch=
        echo "()"
    fi
}

# Fonction pour afficher l'environnement virtuel Python (venv)
venv_prompt() {
    if [[ -n "" ]]; then
        venv_name=""
        echo "()"
    fi
}

# Couleurs pour ls, grep et autres commandes
if [ -x /usr/bin/dircolors ]; then
    eval "LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:';
export LS_COLORS"
    export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90::ow=30;44::ow=30;44:" # Fix couleur pour dossiers 777
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
fi

# Inclure les fichiers cach├®s dans l'auto-compl├®tion
shopt -s dotglob

# Quelques alias utiles
alias '..'='cd ..'
alias '....'='cd ../..'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias gcl="git clone"
alias mini='~/mini-moulinette/mini-moul.sh'
alias lpush="cat ~/leyzen/code/git/token && git push"
 
# Nettoyer les fichiers temporaires de mani├¿re efficace
alias clean_tmp='rm -rf ~/.cache/* /tmp/*'

# Voir l'utilisation du disque de mani├¿re plus lisible
alias disk_usage='du -h --max-depth=1 | sort -h'

# Supprimer les fichiers plus vieux que X jours
alias remove_old_files='find . -type f -mtime +7 -exec rm -f {} \;'

# Auto-completion am├®lior├®e
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Activer la correction orthographique pour 
shopt -s cdspell

# Activer les suggestions automatiques bas├®es sur l'historique
bind 'TAB:menu-complete'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Activer les suggestions d'autocompletion avec le moteur d'historique
bind 'TAB:menu-complete'             # Compl├®tion avec un menu interactif
bind '"\e[A":history-search-backward'   # Fl├¿che vers le haut pour rechercher dans l'historique
bind '"\e[B":history-search-forward'    # Fl├¿che vers le bas pour rechercher dans l'historique

# Raccourci pour ouvrir un fichier dans vim rapidement
bind '"\C-e": "vim "'  # Ctrl + e pour ├®diter un fichier avec vim

# Raccourci pour aller ├á la fin du fichier dans un fichier long
bind '"\C-f": forward-char'  # Ctrl + f pour avancer d'un caract├¿re

# Recherche interactive de commande dans l'historique avec fzf
history_search() {
    history | fzf +s --tac --preview "echo {} | cut -c 8- | xargs -I % man %" | sed 's/^[ ]*[0-9]\+[ ]*//'
}
bind '"\C-r": history-search'  # Ctrl + r pour rechercher des commandes

# Activer les raccourcis clavier similaires ├á Zsh
bind '"\C-u": backward-kill-line'  # Ctrl + U
bind '"\e[3;5~": kill-word'        # Ctrl + Suppr
bind '"\e[3~": delete-char'        # Suppr
bind '"\e[1;5C": forward-word'     # Ctrl + ÔåÆ
bind '"\e[1;5D": backward-word'    # Ctrl + ÔåÉ
bind '"\e[5~": beginning-of-history' # Page Up
bind '"\e[6~": end-of-history'       # Page Down
bind '"\e[H": beginning-of-line'    # Home
bind '"\e[F": end-of-line'          # End

# Command-not-found pour sugg├®rer des commandes non install├®es
if [ -f /etc/bash_command_not_found ]; then
    . /etc/bash_command_not_found
fi

export PATH="$PATH:/bin"
