# -------------------------------------------------------------------
# Docker related aliases
# -------------------------------------------------------------------
alias docklean='docker container prune -f'         # Delete all CONTAINERS that have a status of exited.
alias dockdang='docker image prune -f'             # Forcefully remove DANGLING IMAGES.
alias dockrmi='docker rmi -f $(docker images -q)'  # Forcefully remove ALL IMAGES.
alias dockapocalypse='docker system prune -a -f'   # DANGEROUS. Will delete everything from docker


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
