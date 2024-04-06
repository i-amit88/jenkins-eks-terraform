terraform {
  backend "s3" {
    bucket = "terraform-jenkins-backend-2"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}