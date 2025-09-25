locals {
  vpc_id_value = aws_vpc.firstvpc.id
  all_public_id = aws_subnet.publicsub[*].id
   all_public_cidrs      = ["0.0.0.0/0"]
  public_sub_length = length(var.network.pub_sub_info[0].pubcidr)
  private_sub_length = length(var.network.pri_sub_info[0].pricidr)
}