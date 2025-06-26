env = "dev"

#Vpc variables

vpc_conf = {
cidr = "10.0.0.0/16"
instance_tenancy = "default" 
enable_dns_hostnames = true
enable_dns_support   = true

}

region = "us-east-1"


#Subnets

public_subnets = {
  "us-east-1a" = "10.0.0.0/20"
  "us-east-1b" = "10.0.16.0/20"
}

private_subnets = {
  "us-east-1a" = "10.0.128.0/20"
  "us-east-1b" = "10.0.144.0/20"
}


alb_sg_egress_rules= {
   all = {
        from_port        = 80
        to_port          = 80
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]

   }

}

alb_sg_ingress_rules = {
     https = {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  },

    http = {
        from_port        = 80
        to_port          = 80
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

instance_type = "t3a.medium"
ami_id        = "ami-0427080dd1714168c" # Replace with a valid AMI ID for your region


ec2_sg_egress_rules= {
   all = {
        from_port        = 80
        to_port          = 80
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]

   }

}

ec2_sg_ingress_rules = {
     https = {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  },

    http = {
        from_port        = 80
        to_port          = 80
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

template = file("template/user_data.tpl")

rds_conf = {
  instance_class          = "db.t3.xlarge"
  engine                  = "mysql"
  engine_version          = "8.0.35"
  allocated_storage       = 20
  storage_type            = "gp2"
  multi_az                = true
  username                = "admin"
  db_name                 = "devdb"
  storage_encrypted       = true
  publicly_accessible     = false
  backup_retention_period = 7
}
rds_sg_ingress_rules = {
  https = {
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
}
rds_sg_egress_rules = {
  https = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}