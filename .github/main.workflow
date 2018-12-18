workflow "New workflow" {
  on = "push"
  resolves = [
    "Build",
  ]
}

action "Build" {
  uses = "./.github/actions/docker"
  secrets = ["DOCKER_IMAGE"]
  args = ["build", "Dockerfile"]
}
