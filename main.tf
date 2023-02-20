resource "aws_vpc" "vpc_k8s" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_node_anhdo_vinh"
  }
}
data "aws_availability_zones" "available_zones" {}
# create private data subnet az1
resource "aws_subnet" "subnet_az" {
  vpc_id                  = aws_vpc.vpc_k8s.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = " subnet anhdo vinh"
  }
}
resource "aws_internet_gateway" "vpc_k8s" {
  vpc_id = aws_vpc.vpc_k8s.id
}

resource "aws_route_table" "route_internet" {
  vpc_id = aws_vpc.vpc_k8s.id

  # Route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_k8s.id
  }
}
resource "aws_route_table_association" "vpc3_rt_associatio_1a" {
  subnet_id      = aws_subnet.subnet_az.id
  route_table_id = aws_route_table.route_internet.id
}
resource "aws_key_pair" "vinh_key_2" {
  key_name   = "vinhkey"
  public_key = file("/home/vinh/.ssh/vinhkey.pub")
}


module "master_node" {
  source                 = "./master_node"
  keyname                = "vinhkey"
  type                   = "t2.small"
  ami                    = "ami-0dfcb1ef8550277af"
  subnet_id              = aws_subnet.subnet_az.id
  security_nodes_id      = aws_security_group.k8_nodes.id
  security_k8_masters_id = aws_security_group.k8_masters.id


}
module "worker_node1" {
  source             = "./worker_node1"
  keyname            = "vinhkey"
  type               = "t2.micro"
  ami                = "ami-0dfcb1ef8550277af"
  subnet_id          = aws_subnet.subnet_az.id
  security_nodes_id  = aws_security_group.k8_nodes.id
  security_worker_id = aws_security_group.k8_workers.id

}
module "worker_node2" {
  source             = "./worker_node2"
  keyname            = "vinhkey"
  type               = "t2.micro"
  ami                = "ami-0dfcb1ef8550277af"
  subnet_id          = aws_subnet.subnet_az.id
  security_nodes_id  = aws_security_group.k8_nodes.id
  security_worker_id = aws_security_group.k8_workers.id
}
