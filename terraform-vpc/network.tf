########################
## IGW / NAT Gateways
########################
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  tags = {
    Name = "prod-igw"
  }
}



resource "aws_nat_gateway" "prod-natgw" {
  subnet_id = "${aws_subnet.prod-subnet-public1-1a.id}"
  allocation_id = "${aws_eip.prod-nat-eip.id}"
  tags = {
    Name = "prod-natgw"
  }
}

###############
## EIPs
###############
resource "aws_eip" "prod-nat-eip" {
  vpc = true
  tags = {
    Name = "prod-nat-eip"
  }
}

#####################i
## Route Tables
#####################
## Route table for public outbound, default route to our igw(internet)
resource "aws_route_table" "prod-public-rt" {
  vpc_id = "${aws_vpc.prod-vpc.id}"

  route {
    ## default route
    cidr_block = "0.0.0.0/0"

    ## Route table uses this IGW to get to public internet
    gateway_id = "${aws_internet_gateway.prod-igw.id}"
  }

  tags = {
    Name = "prod-public-rt"
  }
}

resource "aws_route_table" "prod-nat-rt" {
  vpc_id = "${aws_vpc.prod-vpc.id}"

  route {
    ## default route
    cidr_block = "0.0.0.0/0"

    ## Route table uses this IGW to get to public internet
    gateway_id = "${aws_nat_gateway.prod-natgw.id}"
  }

  tags = {
    Name = "prod-nat-rt"
  }
}


## Associate route table with both public subnets so they can see the public igw default route
resource "aws_route_table_association" "prod-rta-public-subnet1-1a" {
  subnet_id = "${aws_subnet.prod-subnet-public1-1a.id}"
  route_table_id = "${aws_route_table.prod-public-rt.id}"
}

resource "aws_route_table_association" "prod-rta-public-subnet2-1b" {
  subnet_id = "${aws_subnet.prod-subnet-public2-1b.id}"
  route_table_id = "${aws_route_table.prod-public-rt.id}"
}

## Associate route table with both private subnets so they can see the private nat outbound only default route
resource "aws_route_table_association" "prod-rta-private-subnet3-1a" {
  subnet_id = "${aws_subnet.prod-subnet-private3-1a.id}"
  route_table_id = "${aws_route_table.prod-nat-rt.id}"
}

resource "aws_route_table_association" "prod-rta-private-subnet4-1b" {
  subnet_id = "${aws_subnet.prod-subnet-private4-1b.id}"
  route_table_id = "${aws_route_table.prod-nat-rt.id}"
}