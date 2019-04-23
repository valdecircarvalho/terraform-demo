provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_vpc" "vpc-demo" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags {
    "Name"        = "vpc-demo"
    "Environment" = "${var.environment}"
  }
}

# Internet Gateway            
resource "aws_internet_gateway" "ig-demo" {
  vpc_id = "${aws_vpc.vpc-demo.id}"

  tags {
    "Name"        = "ig-demo"
    "Environment" = "${var.environment}"
  }
}

# Route Table                 
resource "aws_route_table" "rt-demo" {
  vpc_id = "${aws_vpc.vpc-demo.id}"

  route {
    cidr_block = "${var.route_cidr_block}"
    gateway_id = "${aws_internet_gateway.ig-demo.id}"
  }

  tags {
    "Name"        = "rt-demo"
    "Environment" = "${var.environment}"
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
    "Name"        = "vpc-default"
    "Environment" = "${var.environment}"
  }
}

resource "aws_subnet" "subnet-demo" {
  vpc_id                  = "${aws_vpc.vpc-demo.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  availability_zone       = "${var.aws_availability_zone}"
  map_public_ip_on_launch = false

  tags {
    "Name"        = "sn-demo"
    "Environment" = "${var.environment}"
  }
}

resource "aws_security_group" "sg-demo" {
  name        = "demo"
  description = "demo-web-ssh-icmp"
  vpc_id      = "${aws_vpc.vpc-demo.id}"

  tags {
    "Name"        = "sg-demo"
    "Environment" = "${var.environment}"
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
    "Environment" = "${var.environment}"
  }
}

resource "aws_instance" "web-demo" {
  ami               = "${var.ami}"
  availability_zone = "${var.aws_availability_zone}"
  ebs_optimized     = false
  instance_type     = "t2.micro"
  monitoring        = false

  key_name = "${var.key_name}"

  # key_name = "demo-terraform"

  subnet_id                   = "${aws_subnet.subnet-demo.id}"
  vpc_security_group_ids      = ["${aws_security_group.sg-demo.id}"]
  associate_public_ip_address = true
  source_dest_check           = true
  count                       = "3"
  root_block_device {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
    delete_on_termination = true
  }
  user_data = "${file("../src/install-demo-full.sh")}"
  tags {
    "Environment" = "${var.environment}"
    "Name"        = "web-demo-${count.index}"
  }
}
