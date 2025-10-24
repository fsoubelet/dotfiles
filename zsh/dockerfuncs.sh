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

# Remove a container if it has stopped running
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


# A quick starter for containers I will rely on
relies_on() {
	# Loop over all provided container names
	for container in "$@"; do
		# Check if container exists
		if ! docker inspect "$container" &>/dev/null; then
			echo "Container '$container' does not exist." >&2
			continue
		fi

		# Check if container is running
		local running
		running=$(docker inspect --format "{{.State.Running}}" "$container")

		# Start container if not running, otherwise inform user
		if [[ "$running" == "false" ]]; then
			echo "$container is not running — starting it..."
			docker start "$container"
		else
			echo "$container is already running."
		fi
	done
}
