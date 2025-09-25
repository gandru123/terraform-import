network = {
  vpcname = "firstvpc"
  cidr_block = "10.0.0.0/16"
  pub_sub_info = [ {
    pubcidr = ["10.0.0.0/24", "10.0.1.0/24"]
    pubaz = ["ap-south-1a", "ap-south-1b"]
    pubname = ["web1", "web2"]
  } ]
  pri_sub_info = [ {
    pricidr = ["10.0.3.0/24", "10.0.4.0/24"]
    priaz = ["ap-south-1c", "ap-south-1b"]
    priname = ["web3", "web4"]
  } ]
  ami_id = "ami-0b982602dbb32c5bd"
  instance_type_value = "t3.micro"
  key_name_value = "parvathi"
  server_name = "terr-instance"

}