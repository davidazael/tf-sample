output "server_public_ip" {
  value = aws_eip.one.public_ip
}

output "server_private_ip" {
  value = aws_instance.web-server-instance.private_ip
}

output "server_id" {
  value = aws_instance.web-server-instance.id
}

output "ec2-public-dns" {
  value = aws_instance.web-server-instance.public_dns
}

output "ec2-public-ip" {
  value = aws_instance.web-server-instance.public_ip
}


output "ec2-public-private-dns" {
  value = aws_instance.web-server-instance.private_dns
}

output "ec2-public-private-ip" {
  value = aws_instance.web-server-instance.private_ip
}

output "id" {
  description = "S3 bucket ID"
  value       = aws_s3_bucket.s3_bucket.id
}

output "arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.s3_bucket.arn
}

