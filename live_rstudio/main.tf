resource "aws_s3_bucket" "rstudio" {
  acl = "public-read"

  website {
    index_document = "index.html"
  }

  tags = local.tags
}

resource "aws_s3_bucket_object" "rstudio" {
  bucket       = aws_s3_bucket.rstudio.id
  key          = "index.html"
  acl          = "public-read"
  content      = "<h1>Welcome to the ${var.environment} rstudio environment</h1>"
  content_type = "text/html"

  tags = local.tags
}

resource "aws_security_group" "zomaar_rstudio_SG" {
  name        = format("%s-zomaar_rstudio_SG-sg", var.environment)
  description = "Security group for ${var.environment} app"
  vpc_id      = "vpc-06bceb9729a541195"
  tags = {
    Name     = format("%s-zomaar_rstudio_SG-sg", var.environment)
    Terrafom = true
    Stage    = var.environment
  }
}
