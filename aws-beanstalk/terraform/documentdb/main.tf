module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.application_name}-${var.environment}-db-sg"
  description = "DocumentDB security group"
  vpc_id      = var.vpc_id

  # inbound rules
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 60000
      protocol    = "tcp"
      description = "DocumentDB access from within VPC"
      cidr_blocks = var.cidr
    },
  ]

  # outbound rules
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 60000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    APP_NAME = var.app_tags
  }
}

resource "aws_docdb_subnet_group" "service" {
  name       = "${var.application_name}-${var.environment}-db"
  subnet_ids = var.db_subnets
}

resource "aws_docdb_cluster_instance" "service" {
  count              = 1
  identifier         = "${var.application_name}-${var.environment}-${count.index}"
  cluster_identifier = aws_docdb_cluster.service.id
  instance_class     = var.docdb_instance_class
}

resource "aws_docdb_cluster" "service" {
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_docdb_subnet_group.service.name
  cluster_identifier              = "${var.application_name}-${var.environment}"
  engine                          = "docdb"
  master_username                 = "tfadmin"
  master_password                 = var.docdb_password
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.service.name
  vpc_security_group_ids          = ["${module.security_group.security_group_id}"]
}

resource "aws_docdb_cluster_parameter_group" "service" {
  family = "docdb4.0"
  name   = "${var.application_name}-${var.environment}"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}
