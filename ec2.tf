resource "aws_instance" "web-server-instance" {
  ami               = data.aws_ami.linux_free_tier.id
  instance_type     = var.ec2_instance_type
  availability_zone = "us-east-2a"
  key_name          = aws_key_pair.kp.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.web-server-nic.id
  }

  tags = var.tags

  provisioner "file" {
    source      = "./index.html"
    destination = "/var/www/html/index.html"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./comcastKey.pem")
      host        = self.public_dns
    }
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
                sudo yum install -y httpd
                sudo systemctl enable httpd
                sudo systemctl start httpd && sudo systemctl enable httpd
                sudo yum update -y
                sudo yum install -y mod_ssl
                cd /etc/pki/tls/certs
                sudo ./make-dummy-cert localhost.crt
                cd ~
                sudo sed -i -e '/^SSLCertificateKeyFile/s//#&/' /etc/httpd/conf.d/ssl.conf
                sudo systemctl restart httpd
                sleep 2s
                sudo systemctl start httpd && sudo systemctl enable httpd
                EOF

}
