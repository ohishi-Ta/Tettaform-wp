resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file("./src/test-keypair.pub")
  tags = {
    Name = "${var.project}-${var.environment}-keypair"
  }
}