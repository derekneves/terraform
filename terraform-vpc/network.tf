########################
## IGW / Public Gateways
########################
resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    tags {
        Name = "prod-igw"
    }
}

#####################i
## Route Tables
#####################
## Route table for public outbound, default route to our igw(internet)
resource "aws_route_table" "prod-public-rt" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.prod-igw.id}" 
    }
    
    tags {
        Name = "prod-public-rt"
    }
}

## Associate route table with both public subnets so they can see the default route
resource "aws_route_table_association" "prod-rta-public-subnet1-1a"{
    subnet_id = "${aws_subnet.prod-subnet-public1-1a.id}"
    route_table_id = "${aws_route_table.prod-public-rt.id}"
}

resource "aws_route_table_association" "prod-rta-public-subnet2-1b"{
    subnet_id = "${aws_subnet.prod-subnet-public2-1b.id}"
    route_table_id = "${aws_route_table.prod-public-rt.id}"
}


