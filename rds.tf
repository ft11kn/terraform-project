# create database subnet group
# terraform aws db subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
  name         = "unique-database-subnet-group"
  subnet_ids   = [aws_subnet.private_data_subnet_az1.id, aws_subnet.private_data_subnet_az2.id ]
  description  = "subnets for database instance"

  tags   = {
    Name = "unique-database-subnet-group"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
engine = "mysql"
engine_version = "8.0.39"
multi_az = false
identifier = "dev-rds-instance"
username = "ft11kn"
password = "password123"
instance_class = "db.t3.micro"
allocated_storage = 200
db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
vpc_security_group_ids = [aws_security_group.database_security_group.id]
availability_zone = "us-east-1b"
db_name = "applicationdb"
skip_final_snapshot = true
}

