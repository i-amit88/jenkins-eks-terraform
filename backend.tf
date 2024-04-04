terraform {
  backend "s3" {
    bucket = "terraform-jenkins-backend"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}