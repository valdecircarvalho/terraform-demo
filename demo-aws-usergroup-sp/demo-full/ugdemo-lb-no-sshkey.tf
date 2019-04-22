# Declaração do Provider a ser utilizado
provider "aws" { #provider AWS
  access_key = "FAKE3FGWCKVDTADPFAKE"   # coloque sua access key
  secret_key = "fAkEzr4nHhTlpkycFAKet7Ryvp+OOJ2S/nuGuu0d" #coloque sua secret key
  region     = "us-east-1"
}
resource "aws_vpc" "vpc-demo" {
  cidr_block           = "10.100.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags {
    "Name"     = "vpc-demo"
    "ambiente" = "demo"
  }
}

# Internet Gateway            
resource "aws_internet_gateway" "ig-demo" {
  vpc_id = "${aws_vpc.vpc-demo.id}"

  tags {
    "Name"     = "demo"
    "ambiente" = "demo"
  }
}

# Route Table                 
resource "aws_route_table" "rt-demo" {
  vpc_id = "${aws_vpc.vpc-demo.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig-demo.id}"
  }

  tags {
    "Name"     = "rt-demo"
    "ambiente" = "demo"
  }
}

resource "aws_main_route_table_association" "rtma-demo" {
  vpc_id         = "${aws_vpc.vpc-demo.id}"
  route_table_id = "${aws_route_table.rt-demo.id}"
}

# Configura o default security group da vpc para bloquear todo trafego egress
resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.vpc-demo.id}"

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "acesso icmp ping"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all"
  }

  tags {
    "Name"     = "vpc-default"
    "ambiente" = "demo"
  }
}

resource "aws_subnet" "subnet-demo" {
  vpc_id                  = "${aws_vpc.vpc-demo.id}"
  cidr_block              = "10.100.0.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = false

  tags {
    "Name"     = "sn-demo"
    "ambiente" = "demo"
  }
}

resource "aws_security_group" "sg-demo" {
  name        = "demo"
  description = "demo-web-ssh-icmp"
  vpc_id      = "${aws_vpc.vpc-demo.id}"

  tags {
    "Name"     = "sg-demo"
    "ambiente" = "demo"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "acesso http porta 80"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "acesso ssh porta 22"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "acesso icmp ping"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all"
  }
}

resource "aws_elb" "web" {
  name            = "demo-web-lb"
  subnets         = ["${aws_subnet.subnet-demo.id}"]
  security_groups = ["${aws_security_group.sg-demo.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 5
  }
  
  instances = ["${aws_instance.web-demo.*.id}"]

  tags {
     "ambiente" = "demo"
  }
}


resource "aws_instance" "web-demo" {
  ami               = "ami-0a313d6098716f372"
  availability_zone = "us-east-1c"
  ebs_optimized     = false
  instance_type     = "t2.micro"
  monitoring        = false
 # key_name          = "terraform-user"
  subnet_id         = "${aws_subnet.subnet-demo.id}"

  vpc_security_group_ids = ["${aws_security_group.sg-demo.id}"]

  associate_public_ip_address = true

  source_dest_check = true
  count             = "2"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

#  user_data = "${data.template_file.user_data.rendered}"

  #user_data = "${file("install.sh")}"
user_data = "${file("${path.module}/src/install.sh")}"
  #user_data = "sudo touch /var/log/oi.txt"
  #user_data_base64 =  "${base64encode(file("${path.module}/install.sh"))}"

  tags {
    "ambiente" = "demo"
    "Name"     = "web-demo-${count.index}"
  }
}
