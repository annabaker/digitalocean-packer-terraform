# How to build a Hashicorp Vault server using Packer and Terraform on DigitalOcean 

This project will create an image running a pre-configured Hashicorp Vault server, using Packer to create the image, and then using Terraform to deploy the image to a DigitalOcean droplet.

## Prerequisites

- A DigitalOcean [API key](https://www.digitalocean.com/docs/api/create-personal-access-token/)
- Packer [installed](https://www.packer.io/intro/getting-started/install.html)
- Terraform [installed](https://learn.hashicorp.com/terraform/getting-started/install.html)

First, add your API key to packer/variables.json
Validate the variables and template files.

```shell
cd packer
packer validate -var-file=variables.json template.json
```

Then, build the image.

```shell
packer build -var-file=variables.json template.json
```

Grab the image ID from the output, and add it to terraform/variables.tfvars, along with your DigitalOcean API key.

Initialize Terraform:

```shell
terraform init
```

Get a preview of your changes:

```
terraform plan -var-file=variables.tfvars
```

Lastly, deploy the image to a Droplet:

```shell
terraform apply -var-file=variables.tfvars
```

You can find a more in-depth tutorial on how I built this [here](https://adotpalindrome.wordpress.com/2020/01/12/how-to-build-a-hashicorp-vault-server-using-packer-and-terraform-on-digitalocean/).

