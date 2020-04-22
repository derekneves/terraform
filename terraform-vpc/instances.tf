resource "aws_instance" "prod-web1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"

    subnet_id = "${aws_subnet.prod-subnet-public1-1a.id}"

    security_groups = ["${aws_security_group.inbound-ssh-allowed-restricted.id}", "${aws_security_group.inbound-http_https-allowed.id}"]
    tags = {
        Name = "prod-web1"
    }
}
