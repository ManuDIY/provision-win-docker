# AWS access and secret keys ..
# check http://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html for details on how to get them
# variable "access_key" {}
# variable "secret_key" {}

# The AWS region to launch the instances in
variable "region" {
  default = "eu-central-1"
}


# The number of instances to be launched
variable "instance_count" {
  default = "1"
}

# defining the Administrator password on the created windows instances
variable "admin_password" {
  default = "terraformSetPassword!"
}

# defining instance type
variable "instance_type" {
  default = "t2.micro"
}
