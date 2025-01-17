#------------------
# RDS
#------------------
resource "aws_db_subnet_group" "mysql-subnetgroup" {
  name        = "${var.project}-${var.environment}-mysql-subnetgroup"
  description = "DB Subnet Group"
  subnet_ids  = [aws_subnet.private-subnet-1a.id, aws_subnet.private-subnet-1c.id]
  tags = {
    Name    = "${var.project}-${var.environment}-mysql-subnetgroup"
    Project = var.project
    Env     = var.environment
  }
}


resource "aws_db_instance" "mysql_db" {
  #基本設定
  engine         = "mysql"
  engine_version = "8.0.40"

  identifier = "${var.project}-${var.environment}-mysql"

  username = var.db_username
  password = var.db_password

  instance_class = "db.t3.micro"

  #ストレージ
  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  #ネットワーク
  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.mysql-subnetgroup.name
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  publicly_accessible    = false
  port                   = 3306

  #DB設定
  db_name = "wp_terraform_db"

  #バックアップ
  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:08:00"
  auto_minor_version_upgrade = false

  #削除防止
  deletion_protection = false
  skip_final_snapshot = true

  apply_immediately = true

  tags = {
    Name    = "${var.project}-${var.environment}-mysqldb"
    Project = var.project
    Env     = var.environment
  }
}