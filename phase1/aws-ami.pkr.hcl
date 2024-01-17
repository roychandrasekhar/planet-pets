# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Specific AMI for the Base Image
source "amazon-ebs" "amazon-linux" {
  region        = "us-east-1"
  ami_name      = "custom-ami-{{timestamp}}"
  instance_type = "t2.micro"
  source_ami    = "ami-0005e0cfe09cc9050"
  ssh_username  = "ec2-user"
  profile       = "chandrasekhar"
}

# Install build and create AMI
build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum -y update",
      "sudo yum install git -y",
      "sudo yum install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -y",
      "sudo yum install https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm -y",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start",
      "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status",
      "sudo yum install docker -y",
      "sudo systemctl start docker"
    ]
  }
}
