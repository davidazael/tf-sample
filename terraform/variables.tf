variable "tags" {
  type = map(string)
  default = {
    Name = "SRE"
    Env  = "Test"
  }
}

variable "subnet_prefix" {
  description = "cidr block for the subnet"
}

variable "cidr_block" {
  type        = string
  description = "cidr block set based on number of usable IPs needed."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket"
}

variable "versioning_enabled" {
  type        = string
  description = "Enable versioning"
}

variable "sse_algorithm" {
  type        = string
  description = "The SSE Algorithm of choice"
}

variable "force_destroy" {
  type        = bool
  description = "Force Destroy bool - Should S3 bucket be forcefully destroyed and all its contents within."
}

variable "object_lock_enabled" {
  type        = bool
  description = "Object Lock bool"
}

variable "kp_name" {
  type        = string
  description = "Key Pair Name"

}
variable "tls_algo" {
  type        = string
  description = "TLS Private Key Algorithm"
}

variable "rsa_bits" {
  type        = number
  description = "RSA Bits"
}

variable "dynamo_tb_name" {
  type        = string
  description = "The name of the Dynamo Table"
}

variable "dynamo_bill_mode" {
  type        = string
  description = "Dynamo Billing option of choice."

}

variable "ec2_instance_type" {
  type        = string
  description = "The EC2 Instance type that might be different per environment."

}
