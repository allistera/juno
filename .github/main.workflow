workflow "New workflow" {
  on = "push"
  resolves = [
    "build"
  ]
}
action "Build" {
  uses = "./.github/actions/docker"
  secrets = ["DOCKER_IMAGE"]
  args = ["build", "Dockerfile"]
}
