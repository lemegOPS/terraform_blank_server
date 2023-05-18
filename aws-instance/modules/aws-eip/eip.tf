#---------- Elastic IPs block ----------#

resource "aws_eip" "vpc_eip" {
  count    = length(var.servers)
  instance = var.servers[count.index]
  vpc      = true
  tags     = merge(var.tags, { Name = "${var.global_name}_EIP" })
}
