
# Define AWS region
provider "aws" {
  region = "ap-south-1"
}

# Create s3 bucket for frontend
resource "aws_s3_bucket" "leadrweb" {
  bucket = "leadrweb"
  acl    = "public-read"
  policy = "${file("policy.json")}"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }

}

# Maintain remote terraform state 
terraform {
  backend "s3" {
    bucket = "tf-sls-example"
    key    = "remote_frontend/terraform.tfstate"
    region = "ap-south-1"
  }
}


