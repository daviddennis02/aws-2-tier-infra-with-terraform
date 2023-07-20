# create RDS db resource
resource "aws_db_instance" "db_server" {
  allocated_storage      = 10
  engine                 = "MySQL"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = aws_db_subnet_group.rds_db_subnet.id
  vpc_security_group_ids = [aws_security_group.db_tier.id]
  db_name                = "labdb"
  username               = var.db_username
  password               = var.db_pass
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
}