
# Define AWS region
provider "aws" {
  region = "ap-south-1"
}

# Create s3 bucket for frontend
resource "aws_s3_bucket" "b" {
  bucket = "LeadrWeb"
  acl    = "public"

/*  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
*/
}

# Maintain remote terraform state 
terraform {
  backend "s3" {
    bucket = "tf-sls-example"
    key    = "remote_frontend/terraform.tfstate"
    region = "ap-south-1"
  }
}


