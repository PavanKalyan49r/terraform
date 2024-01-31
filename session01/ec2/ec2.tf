resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139" #devops-practice
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.roboshop_all.id]
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "roboshop_all" { #this is terraform name
  name        = "var.sg-name" #this is aws name
  description = "var.sg-description"
  #vpc_id      = aws_vpc.main.id

  tags = {
    Name = "roboshop_all_aws"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.roboshop_all.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.inbound-from-port # 0 mean all ports
  ip_protocol       = "tcp"
  to_port           = 0
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.roboshop_all.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}