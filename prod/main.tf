# Values provided in gitingored `my.tfvars`

# terraform plan --var-file=my.tfvars
# terraform apply --var-file=my.tfvars

provider "aws" {
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
  region     = var.aws_region     
}



variable "aws_access_key" {} # Your Access Key ID                       (required)
variable "aws_secret_key" {} # Your Secret Access Key                   (required)
variable "aws_vpc_name"   {} # Name of your VPC                         (required)
variable "aws_vpc_id"     {} # ID of your VPC                           (required)

variable "aws_region"     { default = "us-west-2" } # AWS Region
variable "env_id"         { default = "dev"}


module "cf-elb" {
  source     = "git::https://github.com/cweibel/terraform-cf-alb.git?ref=0.0.2"

                # If you change the version, rerun `terraform init -upgrade` to load it
  
  env_id     = "howdy"
  aws_region = var.aws_region
  aws_vpc_id = var.aws_vpc_id

}

## Example output, note that it needs to have a corresponding `output` in the submodule

output "cf_tcp_lb_name" {
  value = "${module.cf-elb.cf_tcp_lb_name}"
}

output "cf_tcp_lb_url" {
  value = "${module.cf-elb.cf_tcp_lb_url}"
}