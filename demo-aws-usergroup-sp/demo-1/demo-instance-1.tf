provider "aws" {
  access_key = "AKIA3FGWCKVDTADPFDUL"                     #provider AWS
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_instance" "web-demo" {
  ami           = "ami-0a313d6098716f372" #ubuntu 
  instance_type = "t2.micro"
  count         = "1"
  # key_name          = "terraform-user"
  
  tags {
    Name = "web-demo-aws-ug-sp"
  }

 #  user_data = "${file("${path.module}/src/install.sh")}"
}
