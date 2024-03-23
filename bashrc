#


dockersec() {
  docker run --runtime=runsc "$@"
}

# Run Docker containers without gVisor (insecure)
dockerun() {
  docker run --runtime=runc "$@"
}