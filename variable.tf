variable "network" {
    description = "this is about vpc and subnet"
    type = object({
      vpcname = string
      cidr_block = string
      pub_sub_info = list(object({
        pubcidr = list(string)
        pubaz = list(string)
        pubname = list(string)
      }))
      pri_sub_info = list(object({
        pricidr = list(string)
        priaz = list(string)
        priname = list(string)
      }))
      ami_id = string
      instance_type_value = string
      key_name_value = string
      #sg_ids = list(string)
      server_name = string

    })
    
    
}