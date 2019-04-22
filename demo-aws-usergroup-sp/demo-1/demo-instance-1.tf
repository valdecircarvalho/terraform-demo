/* Você pode declarar a suas credenciais diretamente no arquio - não muito seguro
provider "aws" { #provider AWS
  access_key = "FAKE3FGWCKVDTADPFAKE"   # coloque sua access key
  secret_key = "fAkEzr4nHhTlpkycFAKet7Ryvp+OOJ2S/nuGuu0d" #coloque sua secret key
  region     = "us-east-1"
} */

## variaveis - serão carregadas do arquivo terraform.tfvars
variable "aws_access_key" {}
variable "aws_secret_key" {}

## Você pode carregar suas credenciais de um arquivo .tfvars
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

resource "aws_instance" "web-demo" {
  ami           = "ami-0a313d6098716f372" #ubuntu 
  instance_type = "t2.micro"
  count         = "1"

  # key_name          = "terraform-user"

  tags {
    Name        = "web-demo-aws-ug-sp"
    Environment = "terraform-demo"
  }

  #  user_data = "${file("${path.module}/src/install.sh")}"
}
