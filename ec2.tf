#------------------
# EC2
#------------------
data "aws_ami" "app" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*.0-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


#------------------
#EC2 Instance
#------------------
resource "aws_instance" "app_server" {
  #基本設定
  ami           = data.aws_ami.app.id
  instance_type = "t2.micro"
  #ネットワーク
  subnet_id                   = aws_subnet.public-subnet-1a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.app-sg.id]
  #その他
  key_name  = aws_key_pair.keypair.key_name
  user_data = file("./userdata.sh")

  tags = {
    Name    = "${var.project}-${var.environment}-app-ec2"
    Project = var.project
    Env     = var.environment
    Type    = "app"
  }

}
