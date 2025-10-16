# ----------------------- #
# SMALL UTILITY FUNCTIONS #
# ----------------------- #

# Turning hidden files on/off in Finder
hiddenOn() { defaults write com.apple.Finder AppleShowAllFiles YES ; }
hiddenOff() { defaults write com.apple.Finder AppleShowAllFiles NO ; }


# Viewing man pages in Preview
pman() { ps=$(mktemp -t manpageXXXX).ps ; man -t "$@" > "$ps" ; open "$ps" ; }

# Prompting IP address
myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# Using streamlink to pull a stream and send it to iina
getstream() {
  streamlink --stdout "$1" best | iina --stdin # First and only argument should be url to the stream
}


# Convert every flac file in current directory into mp3 format
flac_to_mp3() {
  fd --extension flac --exec ffmpeg -i {} -q:a 0 {.}.mp3
}


# Convert every mov file in current directory into mp4 format
mov_to_mp4() {
  fd --extension mov --exec ffmpeg -i {} -r 25 {.}.mp4
}


# Convert every mp4 file in current directory into mkv format
mp4_to_mkv() {
  fd --extension mp4 --exec ffmpeg -i {} -r 25 {.}.mkv
}


# Convert every mkv file in current directory into mp4 format
mkv_to_mp4() {
  fd --extension mkv --exec ffmpeg -i {} -r 25 {.}.mp4
}
