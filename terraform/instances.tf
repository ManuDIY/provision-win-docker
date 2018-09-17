# creating N windows server 2016 instances ready to run Jenkins slave
resource "aws_instance" "docker_machines" {
  ami                         = "${data.aws_ami.ami.image_id}"
  instance_type               = "${var.instance_type}"
  count                       = "${var.instance_count}"
  vpc_security_group_ids      = ["${aws_security_group.Windows_Docker_SG.id}"]
  associate_public_ip_address = true
  subnet_id                   = "${aws_subnet.main.id}"
  user_data                   = "${file("scripts/ec2-userdata.ps1")}"
  root_block_device           = {
                                   volume_size = "${var.volume_size}"
                                }
  tags                        = {
                                   Name  = "Terraform-Win-Docker",
                                   status = "Prod"
                                }
  depends_on                  = ["aws_internet_gateway.gw"]

   provisioner "remote-exec" {
     inline = [
         "net user Administrator ${var.admin_password}",
         "docker pull microsoft/nanoserver",
         "docker pull azuresdk/azure-powershell",
         "docker pull microsoft/windowsservercore",
         "docker pull microsoft/mssql-server-windows-developer",
         "docker pull microsoft/dotnet-framework-samples:4.7.1",
         "docker pull microsoft/dotnet-framework:4.7.1"
         "docker pull microsoft/dotnet-framework-build",
         "docker pull microsoft/iis",
              ]
      connection {
        type     = "winrm"
        user     = "Administrator"
        password = "thisIsJustTemporary!"
        timeout  = "10m"
      }
    }

}
