# -------------------------------------------------------------------
# Docker related aliases
# -------------------------------------------------------------------
alias docklean='docker rm $(docker ps -a -q -f status=exited)'                           # Delete all CONTAINERS that have a status of exited.
alias dock='docker rmi $(docker images --filter "dangling=true" --quiet --no-trunc)'     # Forcefully remove  DANGLING IMAGES.
alias dockrmi='docker rmi $(docker images -q) -f'                                        # Forcefully remove ALL IMAGES.
alias dockapocalypse='docker system prune -a'                                            # DANGEROUS. Will delete everything from docker
alias lzd='lazydocker'


# -------------------------------------------------------------------
# Docker related functions
# -------------------------------------------------------------------
del_stopped() {
	local name=$1
	local state
	state=$(docker inspect --format "{{.State.Running}}" "$name" 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm "$name"
	fi
}

relies_on() {
	for container in "$@"; do
		local state
		state=$(docker inspect --format "{{.State.Running}}" "$container" 2>/dev/null)

		if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
			echo "$container is not running, starting it for you."
			${container}
		fi
	done
}