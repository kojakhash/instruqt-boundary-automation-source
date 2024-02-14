provider "aws" {
  region  = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

# VPC resources
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}

# Subnets
resource "aws_subnet" "public" {
  count             = var.num_subnets_public
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = local.pub_cidrs[count.index]

  tags = {
    Name = "${var.tag}-${random_pet.test.id}-public-${count.index}"
  }
}

resource "aws_db_subnet_group" "test" {
  name       = "test"
  subnet_ids = aws_subnet.public[*].id

  tags = {
    Name = "Test"
  }
}


# Public Routes
resource "aws_route_table" "public" {
  count  = var.num_subnets_public
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.tag}-${random_pet.test.id}-public-${count.index}"
  }
}

resource "aws_route_table_association" "public_subnets" {
  count          = var.num_subnets_public
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.*.id[count.index]
}

resource "aws_route" "public_internet_gateway" {
  count                  = var.num_subnets_public
  route_table_id         = aws_route_table.public.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id

  timeouts {
    create = "5m"
  }
}
