resource "aws_instance" "web_tier1" {
  ami                         = "ami-04823729c75214919"
  key_name                    = "cloudtrybe-lab-sshkey"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public1.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web_tier.id]
  user_data_replace_on_change = true
  user_data                   = file("./scripts/ec2_user_data.sh")

  tags = {
    Name = "webtier1"
  }
}

resource "aws_instance" "web_tier2" {
  ami                         = "ami-04823729c75214919"
  key_name                    = "cloudtrybe-lab-sshkey"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public2.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web_tier.id]
  user_data_replace_on_change = true
  user_data                   = file("./scripts/ec2_user_data.sh")

  tags = {
    Name = "webtier2"
  }
}