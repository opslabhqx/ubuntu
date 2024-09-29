variable "OWNER" {
  default = "opslabhq"
}

variable "GROUP" {
  default = "base"
}

variable "FILE" {
  default = "ubuntu"
}

variable "TAG" {
  default = "latest"
}

group "default" {
  targets = ["build"]
}

target "settings" {
  context = "."
  cache-from = [
    "type=gha"
  ]
  cache-to = [
    "type=gha,mode=max"
  ]
}

target "test" {
  inherits = ["settings"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = []
}

target "build" {
  inherits = ["settings"]
  output   = ["type=docker"]
  tags = [
    "ghcr.io/${OWNER}x/${FILE}",
    "ghcr.io/${OWNER}x/${FILE}:${TAG}",
    "${OWNER}/${FILE}:${TAG}",
    "${OWNER}/${FILE}",
  ]
}

target "push" {
  inherits = ["settings"]
  output   = ["type=registry"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
    "${OWNER}/${FILE}",
    "${OWNER}/${FILE}:${TAG}",
    "ghcr.io/${OWNER}x/${FILE}",
    "ghcr.io/${OWNER}x/${FILE}:${TAG}",
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}",
    "public.ecr.aws/${OWNER}/${GROUP}/${FILE}:${TAG}"
  ]
}
