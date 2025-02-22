terraform {
  cloud {
    organization = "mradul"
    workspaces {
      name = "learn-terraform-aws"
    }
  }

  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "app_server" {
  ami             = "ami-006d9dc984b8eb4b9"
  instance_type   = "t2.micro"
  subnet_id       = "subnet-063167bdf8a645836"
  security_groups = ["sg-0122f2264a5094030"]

  tags = {
    Name = var.instance_name
  }
}

