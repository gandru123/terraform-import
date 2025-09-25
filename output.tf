output "vpc_id_output" {
    value = aws_vpc.firstvpc.id
  
}
output "pub_sub_length" {
    value = local.public_sub_length
}
output "private_sub_ids" {
    #count = length(aws_subnet.privatesubnet.id)
    value = aws_subnet.privatesubnet[*].id
  
}
output "ami_id_output" {
    value = data.aws_ami.ubuntu_ami.id
}