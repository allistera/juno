workflow "New workflow" {
  on = "push"
  resolves = ["build"]
}

action "build" {
  uses = "actions/docker/cli@0c53e4a"
  runs = "build "
  args = "-t juno"
}
