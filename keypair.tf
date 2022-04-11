resource "tls_private_key" "pk" {
  algorithm = var.tls_algo
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "kp" {
  key_name   = var.kp_name
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    when    = create
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./comcastKey.pem"
  }

}
