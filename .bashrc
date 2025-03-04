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
    
    # Détecter si l'utilisateur est root
    if [ "$(id -u)" -eq 0 ]; then
        # root en rouge
        user_host="\[\033[1;31m\](\u$prompt_symbol\h)\[\033[0m\]"
    else
        # Nom d'utilisateur en bleu
        user_host="\[\033[1;34m\](\u$prompt_symbol\h)\[\033[0m\]"
    fi
    
    # Afficher le groupe de l'utilisateur
    local group="\[\033[1;32m\]\$(id -gn)\[\033[0m\]"  # Affiche ton groupe
    local path="\[\033[1;32m\]\w\[\033[0m\]"  # Affiche le répertoire courant
    local git_info="\$(git_prompt)"  # Affiche le statut Git si dans un dépôt
    local venv_info="\$(venv_prompt)"  # Affiche l'environnement virtuel actif si présent
    local prompt_end="\[\033[1;36m\]$\[\033[0m\]"

    # Ajouter l'information de venv avant le nom d'utilisateur et chemin
    PS1="\n┌─$venv_info─$user_host-[$path]$git_info\n└─$prompt_end "
}

# Fonction pour afficher le statut Git
git_prompt() {
    # Vérifier si un dépôt git est présent
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        echo "($branch)"
    fi
}

# Fonction pour afficher l'environnement virtuel Python (venv)
venv_prompt() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv_name=$(basename "$VIRTUAL_ENV")
        echo "($venv_name)"
    fi
}

# Couleurs pour ls, grep et autres commandes
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # Fix couleur pour dossiers 777
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
fi

# Inclure les fichiers cachés dans l'auto-complétion
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

# Nettoyer les fichiers temporaires de manière efficace
alias clean_tmp='rm -rf ~/.cache/* /tmp/*'

# Voir l'utilisation du disque de manière plus lisible
alias disk_usage='du -h --max-depth=1 | sort -h'

# Supprimer les fichiers plus vieux que X jours
alias remove_old_files='find . -type f -mtime +7 -exec rm -f {} \;'

# Auto-completion améliorée
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Activer la correction orthographique pour `cd`
shopt -s cdspell

# Activer les suggestions automatiques basées sur l'historique
bind 'TAB:menu-complete'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# Activer les suggestions d'autocompletion avec le moteur d'historique
bind 'TAB:menu-complete'             # Complétion avec un menu interactif
bind '"\e[A":history-search-backward'   # Flèche vers le haut pour rechercher dans l'historique
bind '"\e[B":history-search-forward'    # Flèche vers le bas pour rechercher dans l'historique

# Raccourci pour ouvrir un fichier dans vim rapidement
bind '"\C-e": "vim "'  # Ctrl + e pour éditer un fichier avec vim

# Raccourci pour aller à la fin du fichier dans un fichier long
bind '"\C-f": forward-char'  # Ctrl + f pour avancer d'un caractère

# Recherche interactive de commande dans l'historique avec fzf
history_search() {
    history | fzf +s --tac --preview "echo {} | cut -c 8- | xargs -I % man %" | sed 's/^[ ]*[0-9]\+[ ]*//'
}
bind '"\C-r": history-search'  # Ctrl + r pour rechercher des commandes

# Activer les raccourcis clavier similaires à Zsh
bind '"\C-u": backward-kill-line'  # Ctrl + U
bind '"\e[3;5~": kill-word'        # Ctrl + Suppr
bind '"\e[3~": delete-char'        # Suppr
bind '"\e[1;5C": forward-word'     # Ctrl + →
bind '"\e[1;5D": backward-word'    # Ctrl + ←
bind '"\e[5~": beginning-of-history' # Page Up
bind '"\e[6~": end-of-history'       # Page Down
bind '"\e[H": beginning-of-line'    # Home
bind '"\e[F": end-of-line'          # End

# Command-not-found pour suggérer des commandes non installées
if [ -f /etc/bash_command_not_found ]; then
    . /etc/bash_command_not_found
fi

# Created by `pipx` on 2025-02-28 15:44:08
export PATH="$PATH:/bin"
