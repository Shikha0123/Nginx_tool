module "netwoking" {
    source = "./network"
    vpc_cidr = var.vpccidr
    vpc_name = var.vpcname
    tenancy = var.vpctenancy
    public_subnet_names = var.pub_sub_names
    pub_cidr = var.pubcidr
    private_subnet_names = var.pvt_sub_names
    pv_cidr = var.pvtcidr
    igw_name = var.igwname
    nat_name = var.natname
    # eip = var.e_ip
    public_route_table_names = var.public_rt_names
    private_route_table_names = var.private_rt_names  
}

module "Security" {
    source = "./security"
    bastion_instance_name = var.pub_instance_name
    private_instance_name = var.pvt_instance_name
    instance_type = var.instancetype
    seq_grp = var.seqgrp
    key_name = var.keyname
    subnet_pub_id = module.netwoking.pub_subnet_id[0]
    subnet_pvt_id = module.netwoking.pri_subnet_id[1]
    vpc_id = module.netwoking.vpc_id
  
}

