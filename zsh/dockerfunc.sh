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
	# Get container name
	local name=$1
	if [[ -z "$name" ]]; then
		echo "Usage: del_stopped <container_name>" >&2
		return 1
	fi

	# Query container state from docker
	local state
	state=$(docker inspect --format "{{.State.Running}}" "$name" 2>/dev/null)

	# Warn and exit if container does not exist
	if [[ $? -ne 0 ]]; then
		echo "Container '$name' not found." >&2
		return 1
	fi

	# Remove container if present and not running, otherwise warn
	if [[ "$state" == "false" ]]; then
		docker rm "$name"
		echo "Removed stopped container: $name"
	else
		echo "Container '$name' is running; not removed."
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
