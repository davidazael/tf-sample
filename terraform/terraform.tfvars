# General 
tags = {
  Name = "SRE"
  Env  = "Test"
}

# EC2
ec2_instance_type = "t2.micro"

# VPC
cidr_block = "10.0.0.0/16"

# Subnet
subnet_prefix = [
  {
    cidr_block = "10.0.1.0/24"
    name       = "private_subnet"
    type       = "private"
  },
  {
    cidr_block = "10.0.0.0/24"
    name       = "public_subnet"
    type       = "public"
  }
]

# Intenet Gateway
# Route Tables

# Dynamo
dynamo_tb_name   = "tf-state-lock-comcast-sre-challenge"
dynamo_bill_mode = "PAY_PER_REQUEST"

# S3 TF State Bucket
bucket_name         = "s3-tf-state-comcast-sre-challenge"
versioning_enabled  = "true"
sse_algorithm       = "AES256"
force_destroy       = true
object_lock_enabled = true

# TLS Key Pair
kp_name  = "comcastKey"
tls_algo = "RSA"
rsa_bits = 4096
