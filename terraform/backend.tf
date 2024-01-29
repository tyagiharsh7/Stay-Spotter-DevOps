terraform {
  backend "s3" {
    bucket = "stayspotter"
    region = "us-west-1"
    key    = "eks/terraform.tfstate"
  }
}
