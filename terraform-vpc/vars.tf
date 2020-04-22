variable "AWS_REGION" {
  default = "us-east-1"
}
## default Amazon Linux 2 AMI for our instances
variable "AMI" {
    type = "map"
    
    default = {
        us-east-1 = "ami-07ebfd5b3428b6f4d"
    }
}