//Creating vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "myterraformvpc"
    }
}

//creating  public subnet
resource "aws_subnet" "publicSubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
}

//creating private subnet
resource "aws_subnet" "privateSubnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
}
//creating internet gateway
resource "aws_internet_gateway" "myIGW" {
    vpc_id = aws_vpc.myvpc.id
}

//creating route table
resource "aws_route_table" "myRT" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIGW.id
    }
}

//creating route table association
resource "aws_route_table_association" "myRTA" {
    subnet_id = aws_subnet.publicSubnet.id
    route_table_id = aws_route_table.myRT.id
}
