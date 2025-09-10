resource "aws_instance" "webserver" {
   ami = var.ami_id
   instance_type = var.instance_type
   availability_zone = var.availability_zone
   vpc_security_group_ids = [aws_security_group.webserver_sg.id]
   key_name = var.key_name
   tags = merge(var.commong_tags,{"Name": var.server_name})

}

resource "aws_security_group" "webserver_sg" {
  name = var.sg_name
  description = var.sg_description
  
  dynamic "ingress" {
     for_each = var.webserver_sg_inboundrules
     content {
        to_port = ingress.value.to_port
        from_port = ingress.value.from_port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
        description = ingress.value.description
     }
   } 

    egress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all ports for all destinations" 
    }
}