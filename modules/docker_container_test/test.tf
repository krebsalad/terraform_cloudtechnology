# Configure the Docker provider
provider "docker" {
}

# Create a container
resource "docker_container" "test_container" {
  image = "${docker_image.ubuntu.latest}"
  name  = "test_container_1"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

