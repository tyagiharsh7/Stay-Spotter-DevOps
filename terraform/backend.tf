variable "region" {}

terraform {
  backend "s3" {
    bucket = "stayspotter"
    region = var.region
    key    = "eks/terraform.tfstate"
  }
}
