resource "aws_vpc" "new_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Custom_VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.new_vpc.id
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Custom_VPC_Public_Subnet"
  }
}

resource "aws_subnet" "public_subnet_2b" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.new_vpc.id
  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "Custom_VPC_Public_Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  cidr_block        = "10.0.3.0/24"
  vpc_id            = aws_vpc.new_vpc.id
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "Custom_VPC_Private_Subnet"
  }
}

# resource "aws_subnet" "private_subnet_3b" {
#   cidr_block        = "10.4.0.0/24"
#   vpc_id            = aws_vpc.new_vpc.id
#   availability_zone = "ap-northeast-2b"

#   tags = {
#     Name = "Custom_VPC_Private_Subnet"
#   }
# }

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name = "Custom_igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  tags = {
    Name = "custom_public_route_table"
  }
}

resource "aws_route_table_association" "public_route_table" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name = "custom_private_route_table"
  }
}

resource "aws_route_table_association" "private_route_table" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
