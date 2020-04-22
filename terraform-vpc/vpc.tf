resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.100.1.0/16"
    enable_dns_support = "true" 
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags {
        Name = "prod-vpc"
    }
}

###########
## Subnets
###########
## Two public subnets, 1 in each availiblity zone, 2 AZs leveraged
resource "aws_subnet" "prod-subnet-public1-1a" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags {
        Name = "prod-subnet-public1-1a"
    }
}

resource "aws_subnet" "prod-subnet-public2-1b" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.2.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = "us-east-1b"
    tags {
        Name = "prod-subnet-public2-1b"
    }
}

## Two private subnets, 1 in each availiblity zone, 2 AZs leveraged, no public IP assignment to hosts in these subnets
resource "aws_subnet" "prod-subnet-private3-1a" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.3.0/24"
    availability_zone = "us-east-1a"
    tags {
        Name = "prod-subnet-private3-1a"
    }
}

resource "aws_subnet" "prod-subnet-private4-1b" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.4.0/24"
    availability_zone = "us-east-1b"
    tags {
        Name = "prod-subnet-private4-1b"
    }
}

## Two local/protected subnets
resource "aws_subnet" "prod-subnet-local5-1a" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.5.0/24"
    availability_zone = "us-east-1a"
    tags {
        Name = "prod-subnet-local5-1a"
    }
}

resource "aws_subnet" "prod-subnet-local6-1b" {
    vpc_id = "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.100.6.0/24"
    availability_zone = "us-east-1b"
    tags {
        Name = "prod-subnet-local6-1b"
    }
}

