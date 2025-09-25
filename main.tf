resource "aws_vpc" "firstvpc" {
    cidr_block = var.network.cidr_block
    tags = {
      Name = var.network.vpcname
    }
  
}
resource "aws_subnet" "publicsub" {
    count = local.public_sub_length
    vpc_id = local.vpc_id_value
    cidr_block = var.network.pub_sub_info[0].pubcidr[count.index]
    availability_zone = var.network.pub_sub_info[0].pubaz[count.index]
    tags = {
        Name = var.network.pub_sub_info[0].pubname[count.index]
    }
  
}
resource "aws_subnet" "privatesubnet" {
    count = local.private_sub_length
    vpc_id = local.vpc_id_value
    cidr_block = var.network.pri_sub_info[0].pricidr[count.index]
    availability_zone = var.network.pri_sub_info[0].priaz[count.index]
    tags = {
        Name = var.network.pri_sub_info[0].priname[count.index]
    }
}
resource "aws_internet_gateway" "gate" {
    vpc_id = local.vpc_id_value
    tags = {
        Name = "owngate"
    }
  
}
resource "aws_route_table" "pubroute" {
    count = local.public_sub_length
    vpc_id = local.vpc_id_value
    route {
        cidr_block = local.all_public_cidrs[0]
        gateway_id = aws_internet_gateway.gate.id

    }
    tags = {
      Name = "mypubroute"
    }
  
}
resource "aws_route_table" "priroute" {
    count = local.private_sub_length
    vpc_id = local.vpc_id_value
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.natgate.id

    }
    tags = {
      Name = "mypriroute"
    }
  
}
resource "aws_nat_gateway" "natgate" {
    connectivity_type = "private"
    subnet_id = aws_subnet.publicsub[0].id
    tags = {
      Name = "ownnat"
    }
  
}
resource "aws_route_table_association" "mypubrouteassoci" {
    count = local.public_sub_length
    route_table_id = aws_route_table.pubroute[count.index].id
    subnet_id = local.all_public_id[count.index]
  
}
resource "aws_route_table_association" "myprirouteassoci" {
    count = local.private_sub_length
    subnet_id = aws_subnet.privatesubnet[count.index].id
    route_table_id = aws_route_table.priroute[count.index].id
  
}
resource "aws_security_group" "my_sg" {
  name        = "sg"
  description = "this is about inbound and outbound"
  vpc_id      = local.vpc_id_value

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.all_public_cidrs
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.all_public_cidrs
  }

  tags = {
    Name = "securityh"
  }
}
data "aws_ami" "ubuntu_ami" {
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu-pro-server/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-pro-server-20250819"]
  }

}

resource "aws_instance" "firstinstance"{
    ami = var.network.ami_id
    instance_type = var.network.instance_type_value
    key_name = var.network.key_name_value
    subnet_id = aws_subnet.publicsub[0].id  
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    tags = {
      Name = var.network.server_name
    }
}