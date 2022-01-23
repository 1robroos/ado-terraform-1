### Dynamic Values ------------------------------
### ---------------------------------------------
variable "ec2_type" {
  type = map
  default = {
    dev = "t3a.nano"
    stg = "t3a.micro"
    prd = "t3a.small"
  }
}
### ---------------------------------------------


### Locals Values -------------------------------
### ---------------------------------------------
locals {
  prefix   = "${var.app_name}-${var.environment}"
  ec2_type = "${lookup(var.ec2_type, var.environment)}"
  

  tags = {
    "Environment" : var.environment,
    "Terraform" : "true"
  }
}
### ---------------------------------------------


### Static Values DON'T TOUCH -------------------
### ---------------------------------------------
variable "app_name" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type        = string
  description = "dev, stg, prd"
}
### ---------------------------------------------
