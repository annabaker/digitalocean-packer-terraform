# Set the variable value in *.tfvars file
variable "do_api_token" {}
variable "image_id" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_api_token}"
}

# Create a new droplet from an existing image
resource "digitalocean_droplet" "web" {
  image  = "${var.image_id}"
  name   = "vault"
  region = "nyc1"
  size   = "1gb"
}

