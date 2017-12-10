# Instructions on your machine (requires Packer and Terraform)

Set your AWS keys:

      export AWS_ACCESS_KEY_ID=<<access_key>>
      export AWS_SECRET_ACCESS_KEY=<<secret_key>>

You can generate the AWS AMI and store it in your AWS account by running the following command:

> default region is eu-central-1, you can override it with -var region=<<another_region>>

      cd packer
      packer build packer-win-ami.json -var instance_type=t2.small

Now you can run terraform to provision VMs:

> default region is eu-central-1, you can override it with -var region=<<another_region>>
> the admin_password below should comply with Windows Server 2016 password policy

      cd terraform
      terraform init
      terraform apply -var admin_password=<<some password>> -var instance_count=<<number of VMs>> -var volume_size=<<the volume size in GB - default is 50GB >>

Destroy the resources created by terraform:

      terraform destroy

> running terraform may end with an error, but usually creates the VMs.

# Instructions using docker

      $ cd terraform
      $ docker run -i -t -v $(pwd):/tmp  hashicorp/terraform:light init /tmp; terraform apply  -var admin_password=MyWindowsServer2016ValidPassword! -var instance_count=1 -var volume_size=60

# Get the list of public IP addressses

    jq -r '.modules[0].resources | .[] | select(.type=="aws_instance") | .primary.attributes.public_ip' terraform.tfstate | nl
