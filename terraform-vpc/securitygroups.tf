resource "aws_security_group" "inbound-ssh-allowed-restricted" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  name = "inbound-ssh-allowed-restricted"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["174.91.0.0/16"]
  }
  tags = {
    Name = "inbound-ssh-allowed-restricted"
  }
}

resource "aws_security_group" "inbound-http_https-allowed" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  name = "inbound-http_https-allowed"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "inbound-http_https-allowed"
  }
}


