resource "aws_vpc" "lsedek_lab" {
  cidr_block = "10.99.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "TF_LAB_VPC"
  }
}

resource "aws_internet_gateway" "lsedek_lab_igw" {
  vpc_id = "${aws_vpc.lsedek_lab.id}"

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = "${aws_vpc.lsedek_lab.id}"
  cidr_block = "10.99.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "FirstSubnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id = "${aws_vpc.lsedek_lab.id}"
  cidr_block = "10.99.1.0/24"
  availability_zone = "eu-west-2b"
  
  tags = {
    Name = "FirstSubnet2"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = "${aws_vpc.lsedek_lab.id}"
  
  tags = {
    Name = "RT1"
  }
  
}

resource "aws_route" "default_route" {
  route_table_id = "${aws_route_table.rt1.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.lsedek_lab_igw.id}"

}