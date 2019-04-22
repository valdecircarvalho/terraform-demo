provider "aws" { #provider AWS
  access_key = "FAKE3FGWCKVDTADPFAKE"   # coloque sua access key
  secret_key = "fAkEzr4nHhTlpkycFAKet7Ryvp+OOJ2S/nuGuu0d" #coloque sua secret key
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
