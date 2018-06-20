# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# Enable flags completion 
source $(dirname $(gem which colorls))/tab_complete.sh
