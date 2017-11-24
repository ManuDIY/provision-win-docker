# creating security group
 resource "aws_security_group" "Windows_Docker_SG" {

  vpc_id    = "${aws_vpc.windows_vpc.id}"

  # Allow all inbound
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }

  # Allow WinRM connections on http/https from anywhere
  ingress {
    from_port       = 5985
    to_port         = 5986
    protocol        = "6"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # RDP from anywhere
  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "6"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # Allow all outbound
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name = "Windows_Docker_SG"
    Description = "allows all connections out and RDP and HTTP in."
  }
}
