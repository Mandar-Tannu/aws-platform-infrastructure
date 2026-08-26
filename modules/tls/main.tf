#########################################################
# Private Key
#########################################################

resource "tls_private_key" "this" {

  algorithm = "RSA"

  rsa_bits = 2048

}

#########################################################
# Self Signed Certificate
#########################################################

resource "tls_self_signed_cert" "this" {

  private_key_pem = tls_private_key.this.private_key_pem

  validity_period_hours = 8760

  early_renewal_hours = 720

  is_ca_certificate = false

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]

  dns_names = [
    var.alb_dns_name
  ]

  subject {

    common_name = var.alb_dns_name

    organization = "Demo"

  }
}

#########################################################
# ACM Certificate
#########################################################

resource "aws_acm_certificate" "this" {

  private_key = tls_private_key.this.private_key_pem

  certificate_body = tls_self_signed_cert.this.cert_pem

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-self-signed-certificate"
    }
  )

}


