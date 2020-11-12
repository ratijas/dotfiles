# Docker aliases

alias dps="docker ps"
alias dpsa="docker ps -a"

# Monitoring
alias sen="docker run -v /var/run/docker.sock:/run/docker.sock -it --rm -e TERM tomastomecek/sen"


# Docker-compose aliases

alias dco='docker-compose'

alias dcb='docker-compose build'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcr='docker-compose run'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcdn='docker-compose down'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dcpull='docker-compose pull'
alias dcstart='docker-compose start'
alias dck='docker-compose kill'
