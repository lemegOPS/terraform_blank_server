output "vpc_eip" {
  value = aws_eip.vpc_eip[*].public_ip
}