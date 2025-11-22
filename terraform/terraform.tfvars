nodes = {
  minikube = {
    ami                 = "ami-0d3684aec6d12c883"
    instance_type       = "m7i-flex.large"
    key_name            = "KP-1"
    subnet_id           = "subnet-0c05650f6e7e79b5b"
    security_group_ids  = ["sg-0c4f27885f25543ce"]
    root_volume_size    = 20
    associate_public_ip = true
    user_data           = <<-EOF
      #!/bin/bash
      sudo yum update -y
      sudo amazon-linux-extras enable docker
      sudo yum install -y docker
      sudo service docker start
      sudo usermod -a -G docker ec2-user
      sudo yum install -y conntrack curl
      curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
      sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

      curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
      sudo install minikube-linux-amd64 /usr/local/bin/minikube
      sudominikube start --force
    EOF
  }

  gitlab = {
    ami                 = "ami-0d3684aec6d12c883"
    instance_type       = "m7i-flex.large"
    key_name            = "KP-1"
    subnet_id           = "subnet-0c05650f6e7e79b5b"
    security_group_ids  = ["sg-0c4f27885f25543ce"]
    root_volume_size    = 30
    associate_public_ip = true
    # no user_data needed
  }

  monitoring = {
    ami                 = "ami-0d3684aec6d12c883"
    instance_type       = "m7i-flex.large"
    key_name            = "KP-1"
    subnet_id           = "subnet-0c05650f6e7e79b5b"
    security_group_ids  = ["sg-0c4f27885f25543ce"]
    root_volume_size    = 15
    associate_public_ip = false
    # no user_data needed
  }
}
