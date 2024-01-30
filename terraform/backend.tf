terraform {
  backend "s3" {
    bucket = "stayspotter"
    region = "us-east-1"
    key    = "stayspotter/eks/terraform.tfstate"
  }
}
