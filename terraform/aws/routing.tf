resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
        Name = "public route"
    }
}

resource "aws_route_table_association" "public" {
   subnet_id = aws_subnet.public.id
   route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "aws_instance.nat.id"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
