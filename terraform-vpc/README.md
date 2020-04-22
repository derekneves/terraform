# Terraform-VPC

Terraform scripts to build a VPC within AWS with the following Subnets, Internet gateways, NAT gateways, Security groups, etc
- 2 public subnets, each in seperate availiblty zones; 1 IGW for each for egress/ingress public routing
- 2 private subnets, each in seperate availiblty zones; 1 NATGW for outbound internet access
- 2 local subnets, each in seperate availiblty zones; can only reach internal subnets/vpc supernet
- EIP for NATGW outbound
- Route associations for the required subnets
- tags

More comments in terraform scripts


## Getting Started
clone this repo
```
terraform init
terraform plan -out plan1
```
review plan1 output file
```
terraform apply "plan1"
```
### Prerequisites
```
aws-cli/2.0.8
Terraform v0.12.24
+ provider.aws v2.58.0
```
aws-cli should be configured and working to access your aws account

```
deco@MacBook-Pro terraform-vpc % ls
network.tf              securitygroups.tf       vpc.tf
provider.tf             vars.tf


deco@MacBook-Pro terraform-vpc % terraform init

Initializing the backend...

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.58"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

deco@MacBook-Pro terraform-vpc % terraform plan -out plan1
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.prod-nat-eip will be created
  + resource "aws_eip" "prod-nat-eip" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + tags              = {
          + "Name" = "prod-nat-eip"
        }
      + vpc               = true
    }

  # aws_internet_gateway.prod-igw will be created
  + resource "aws_internet_gateway" "prod-igw" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "prod-igw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_nat_gateway.prod-natgw will be created
  + resource "aws_nat_gateway" "prod-natgw" {
      + allocation_id        = (known after apply)
      + id                   = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip           = (known after apply)
      + public_ip            = (known after apply)
      + subnet_id            = (known after apply)
      + tags                 = {
          + "Name" = "prod-natgw"
        }
    }

  # aws_route_table.prod-nat-rt will be created
  + resource "aws_route_table" "prod-nat-rt" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "prod-nat-rt"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.prod-public-rt will be created
  + resource "aws_route_table" "prod-public-rt" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "prod-public-rt"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.prod-rta-private-subnet3-1a will be created
  + resource "aws_route_table_association" "prod-rta-private-subnet3-1a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.prod-rta-private-subnet4-1b will be created
  + resource "aws_route_table_association" "prod-rta-private-subnet4-1b" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.prod-rta-public-subnet1-1a will be created
  + resource "aws_route_table_association" "prod-rta-public-subnet1-1a" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.prod-rta-public-subnet2-1b will be created
  + resource "aws_route_table_association" "prod-rta-public-subnet2-1b" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.inbound-http_https-allowed will be created
  + resource "aws_security_group" "inbound-http_https-allowed" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "inbound-http_https-allowed"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.inbound-ssh-allowed-restricted will be created
  + resource "aws_security_group" "inbound-ssh-allowed-restricted" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "174.91.0.0/16",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "inbound-ssh-allowed-restricted"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.prod-subnet-local5-1a will be created
  + resource "aws_subnet" "prod-subnet-local5-1a" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.5.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-local5-1a"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.prod-subnet-local6-1b will be created
  + resource "aws_subnet" "prod-subnet-local6-1b" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.6.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-local6-1b"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.prod-subnet-private3-1a will be created
  + resource "aws_subnet" "prod-subnet-private3-1a" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.3.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-private3-1a"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.prod-subnet-private4-1b will be created
  + resource "aws_subnet" "prod-subnet-private4-1b" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.4.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-private4-1b"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.prod-subnet-public1-1a will be created
  + resource "aws_subnet" "prod-subnet-public1-1a" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-public1-1a"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.prod-subnet-public2-1b will be created
  + resource "aws_subnet" "prod-subnet-public2-1b" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.100.2.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "prod-subnet-public2-1b"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.prod-vpc will be created
  + resource "aws_vpc" "prod-vpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.100.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = false
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "prod-vpc"
        }
    }

Plan: 18 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: plan1

To perform exactly these actions, run the following command to apply:
    terraform apply "plan1"

deco@MacBook-Pro terraform-vpc % terraform apply "plan1"  
aws_eip.prod-nat-eip: Creating...
aws_vpc.prod-vpc: Creating...
aws_eip.prod-nat-eip: Creation complete after 1s [id=eipalloc-0ab9d43cc0e713679]
aws_vpc.prod-vpc: Creation complete after 3s [id=vpc-043c90c3ff00605ec]
aws_subnet.prod-subnet-public1-1a: Creating...
aws_subnet.prod-subnet-private4-1b: Creating...
aws_subnet.prod-subnet-public2-1b: Creating...
aws_subnet.prod-subnet-local6-1b: Creating...
aws_internet_gateway.prod-igw: Creating...
aws_subnet.prod-subnet-local5-1a: Creating...
aws_subnet.prod-subnet-private3-1a: Creating...
aws_security_group.inbound-http_https-allowed: Creating...
aws_security_group.inbound-ssh-allowed-restricted: Creating...
aws_internet_gateway.prod-igw: Creation complete after 1s [id=igw-0f2c5cc6119cf772a]
aws_route_table.prod-public-rt: Creating...
aws_subnet.prod-subnet-local5-1a: Creation complete after 1s [id=subnet-0eddea1a9609b70a7]
aws_subnet.prod-subnet-private3-1a: Creation complete after 1s [id=subnet-0675d344fe08c9de1]
aws_subnet.prod-subnet-private4-1b: Creation complete after 1s [id=subnet-00fc82638f3eaa2d2]
aws_subnet.prod-subnet-local6-1b: Creation complete after 1s [id=subnet-062c6317d9a2a6bac]
aws_subnet.prod-subnet-public2-1b: Creation complete after 1s [id=subnet-0991385bf37aa03ae]
aws_subnet.prod-subnet-public1-1a: Creation complete after 1s [id=subnet-064fb5fc273622b13]
aws_nat_gateway.prod-natgw: Creating...
aws_route_table.prod-public-rt: Creation complete after 1s [id=rtb-0ae33f85a3c6c6ae6]
aws_route_table_association.prod-rta-public-subnet2-1b: Creating...
aws_route_table_association.prod-rta-public-subnet1-1a: Creating...
aws_security_group.inbound-http_https-allowed: Creation complete after 2s [id=sg-0bf54b349ccce686d]
aws_security_group.inbound-ssh-allowed-restricted: Creation complete after 2s [id=sg-06aee3f7cb2713a2a]
aws_route_table_association.prod-rta-public-subnet2-1b: Creation complete after 0s [id=rtbassoc-0ab350a3ee8d2b78d]
aws_route_table_association.prod-rta-public-subnet1-1a: Creation complete after 0s [id=rtbassoc-03653825af53e1343]
aws_nat_gateway.prod-natgw: Still creating... [10s elapsed]
aws_nat_gateway.prod-natgw: Still creating... [2m10s elapsed]
aws_nat_gateway.prod-natgw: Creation complete after 2m17s [id=nat-05a39d65ac9505af1]
aws_route_table.prod-nat-rt: Creating...
aws_route_table.prod-nat-rt: Creation complete after 1s [id=rtb-0185849a6af68859d]
aws_route_table_association.prod-rta-private-subnet4-1b: Creating...
aws_route_table_association.prod-rta-private-subnet3-1a: Creating...
aws_route_table_association.prod-rta-private-subnet3-1a: Creation complete after 0s [id=rtbassoc-0f8b6863d4548d9ea]
aws_route_table_association.prod-rta-private-subnet4-1b: Creation complete after 0s [id=rtbassoc-0f4694e1628217980]

Apply complete! Resources: 18 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate
deco@MacBook-Pro terraform-vpc % 
```
