# Terraform-VPC

Terraform scripts to build a VPC within AWS with the following Subnets, Internet gateways, NAT gateways, Security groups, etc
- 2 public subnets, each in seperate availiblty zones; 1 IGW for each for egress/ingress public routing
- 2 private subnets, each in seperate availiblty zones; 1 NATGW for outbound internet access, no ingress
- 2 local subnets, each in seperate availiblty zones; can only reach internal subnets/vpc supernet
- EIP for NATGW outbound
- Route associations for the required subnets
- security groups: ssh and http/https for ingress traffic to public subnet instances to be created
- 1 ec2 ubuntu instance within public subnet, reachable via ssh from home IP and 80 from anywhere
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



#### WITH EC2

deco@MacBook-Pro terraform-vpc % terraform plan -out plan2
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_vpc.prod-vpc: Refreshing state... [id=vpc-043c90c3ff00605ec]
aws_eip.prod-nat-eip: Refreshing state... [id=eipalloc-0ab9d43cc0e713679]
aws_subnet.prod-subnet-local6-1b: Refreshing state... [id=subnet-062c6317d9a2a6bac]
aws_subnet.prod-subnet-local5-1a: Refreshing state... [id=subnet-0eddea1a9609b70a7]
aws_subnet.prod-subnet-public1-1a: Refreshing state... [id=subnet-064fb5fc273622b13]
aws_subnet.prod-subnet-private4-1b: Refreshing state... [id=subnet-00fc82638f3eaa2d2]
aws_subnet.prod-subnet-public2-1b: Refreshing state... [id=subnet-0991385bf37aa03ae]
aws_subnet.prod-subnet-private3-1a: Refreshing state... [id=subnet-0675d344fe08c9de1]
aws_internet_gateway.prod-igw: Refreshing state... [id=igw-0f2c5cc6119cf772a]
aws_security_group.inbound-ssh-allowed-restricted: Refreshing state... [id=sg-0e2b09a3d50200eb9]
aws_security_group.inbound-http_https-allowed: Refreshing state... [id=sg-047419ea2014e9d8a]
aws_route_table.prod-public-rt: Refreshing state... [id=rtb-0ae33f85a3c6c6ae6]
aws_nat_gateway.prod-natgw: Refreshing state... [id=nat-05a39d65ac9505af1]
aws_instance.prod-web1: Refreshing state... [id=i-090a8135729256c0d]
aws_route_table_association.prod-rta-public-subnet1-1a: Refreshing state... [id=rtbassoc-03653825af53e1343]
aws_route_table_association.prod-rta-public-subnet2-1b: Refreshing state... [id=rtbassoc-0ab350a3ee8d2b78d]
aws_route_table.prod-nat-rt: Refreshing state... [id=rtb-0185849a6af68859d]
aws_route_table_association.prod-rta-private-subnet4-1b: Refreshing state... [id=rtbassoc-0f4694e1628217980]
aws_route_table_association.prod-rta-private-subnet3-1a: Refreshing state... [id=rtbassoc-0f8b6863d4548d9ea]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_instance.prod-web1 is tainted, so must be replaced
-/+ resource "aws_instance" "prod-web1" {
        ami                          = "ami-07ebfd5b3428b6f4d"
      ~ arn                          = "arn:aws:ec2:us-east-1:372093060897:instance/i-090a8135729256c0d" -> (known after apply)
      ~ associate_public_ip_address  = true -> (known after apply)
      ~ availability_zone            = "us-east-1a" -> (known after apply)
      ~ cpu_core_count               = 1 -> (known after apply)
      ~ cpu_threads_per_core         = 1 -> (known after apply)
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
        get_password_data            = false
      - hibernation                  = false -> null
      + host_id                      = (known after apply)
      ~ id                           = "i-090a8135729256c0d" -> (known after apply)
      ~ instance_state               = "running" -> (known after apply)
        instance_type                = "t2.micro"
      ~ ipv6_address_count           = 0 -> (known after apply)
      ~ ipv6_addresses               = [] -> (known after apply)
        key_name                     = "prod-key-pair"
      - monitoring                   = false -> null
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      ~ primary_network_interface_id = "eni-0acc2903e9001338d" -> (known after apply)
      ~ private_dns                  = "ip-10-100-1-138.ec2.internal" -> (known after apply)
      ~ private_ip                   = "10.100.1.138" -> (known after apply)
      ~ public_dns                   = "ec2-3-93-16-188.compute-1.amazonaws.com" -> (known after apply)
      ~ public_ip                    = "3.93.16.188" -> (known after apply)
      ~ security_groups              = [
          + "sg-047419ea2014e9d8a",
          + "sg-0e2b09a3d50200eb9",
        ]
        source_dest_check            = true
        subnet_id                    = "subnet-064fb5fc273622b13"
        tags                         = {
            "Name" = "prod-web1"
        }
      ~ tenancy                      = "default" -> (known after apply)
      ~ volume_tags                  = {} -> (known after apply)
      ~ vpc_security_group_ids       = [
          - "sg-047419ea2014e9d8a",
          - "sg-0e2b09a3d50200eb9",
        ] -> (known after apply)

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      ~ metadata_options {
          ~ http_endpoint               = "enabled" -> (known after apply)
          ~ http_put_response_hop_limit = 1 -> (known after apply)
          ~ http_tokens                 = "optional" -> (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      ~ root_block_device {
          ~ delete_on_termination = true -> (known after apply)
          ~ device_name           = "/dev/sda1" -> (known after apply)
          ~ encrypted             = false -> (known after apply)
          ~ iops                  = 100 -> (known after apply)
          + kms_key_id            = (known after apply)
          ~ volume_id             = "vol-05d5841943014148f" -> (known after apply)
          ~ volume_size           = 8 -> (known after apply)
          ~ volume_type           = "gp2" -> (known after apply)
        }
    }

  # aws_route_table.prod-nat-rt will be updated in-place
  ~ resource "aws_route_table" "prod-nat-rt" {
        id               = "rtb-0185849a6af68859d"
        owner_id         = "372093060897"
        propagating_vgws = []
      ~ route            = [
          - {
              - cidr_block                = "0.0.0.0/0"
              - egress_only_gateway_id    = ""
              - gateway_id                = ""
              - instance_id               = ""
              - ipv6_cidr_block           = ""
              - nat_gateway_id            = "nat-05a39d65ac9505af1"
              - network_interface_id      = ""
              - transit_gateway_id        = ""
              - vpc_peering_connection_id = ""
            },
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = "nat-05a39d65ac9505af1"
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
        tags             = {
            "Name" = "prod-nat-rt"
        }
        vpc_id           = "vpc-043c90c3ff00605ec"
    }

Plan: 1 to add, 1 to change, 1 to destroy.

------------------------------------------------------------------------

This plan was saved to: plan2

To perform exactly these actions, run the following command to apply:
    terraform apply "plan2"

deco@MacBook-Pro terraform-vpc %

deco@MacBook-Pro ~ % ssh-add .ssh/prod-key-pair.pem       
Identity added: .ssh/prod-key-pair.pem (.ssh/prod-key-pair.pem)

deco@MacBook-Pro ~ % ssh ubuntu@3.93.16.188
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-1057-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed Apr 22 05:18:51 UTC 2020

  System load:  0.04              Processes:           89
  Usage of /:   13.6% of 7.69GB   Users logged in:     0
  Memory usage: 15%               IP address for eth0: 10.100.1.138
  Swap usage:   0%

0 packages can be updated.
0 updates are security updates.

ubuntu@ip-10-100-1-138:~$ 

