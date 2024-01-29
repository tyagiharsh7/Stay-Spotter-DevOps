terraform {
  backend "s3" {
    bucket = "stayspotter"
    region = "us-west-1"
    key    = "stayspotter/eks/terraform.tfstate"
  }
}
