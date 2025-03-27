#Security Group for ALB
resource "aws_security_group" "alb_sg" {
    name_prefix = "alb-sg"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}

#Security Group for EC2 Instances
resource "aws_security_group" "instance_sg" {
    name_prefix = "instance-sg"
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
  
}