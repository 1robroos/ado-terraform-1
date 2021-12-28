# module "vpc" {
#   source             = "terraform-aws-modules/vpc/aws"
#   version            = "~>2.0"
#   name               = local.prefix
#   cidr               = local.vpc_cidr
#   private_subnets    = local.private_subnets
#   public_subnets     = local.public_subnets
#   enable_nat_gateway = false
#   enable_vpn_gateway = false

#   azs = local.availability_zones

#   tags = local.tags
# }


# 27-12-2021: created bucket name in dev is terraform-20211227154220019500000001
resource "aws_s3_bucket" "app" {
  acl = "public-read"

  website {
    index_document = "index.html"
  }

  tags = local.tags
}

resource "aws_s3_bucket_object" "app" {
  bucket       = aws_s3_bucket.app.id
  key          = "index.html"
  acl          = "public-read"
  content      = "<h1>Welcome to the ${var.environment} environment</h1>"
  content_type = "text/html"

  tags = local.tags
}



resource "aws_security_group" "zomaar" {
  name        = format("%s-zomaar-sg", var.environment)
  description = "Security group for ${var.environment} app"
  vpc_id      = "vpc-06bceb9729a541195"
  tags = {
    Name = format("%s-zomaar-sg", var.environment)
    Terrafom = yes
  }
}