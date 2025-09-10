variable "aws_region" {
  type = string
  description = "AWS Region to be used to create resource"
  default = "ap-south-1"
}

variable "ami_id" {
  type = string
  description = "AMI Id "
  default = "ami-0861f4e788f5069dd"
}

variable "instance_type" {
  type = string
  default = "t3.micro"
  description = "Ec2 Instance Type"
}

variable "server_name" {
  type = string
  default = "WebServer"
}

variable "commong_tags" {
  type = map(string)
  default = {
    "MangedBy" = "IaC"
    "ENV" = "dev"
  }
}

variable "availability_zone" {
  type = string
  default = "ap-south-1a"
}

variable "sg_name" {
  type = string
  default = "webserver-sg"
}

variable "sg_description" {
  type = string
  default = "Web Server S.G Allow SSH And HTTP Ports"
}

variable "webserver_sg_inboundrules" {

  type = list(object({
    to_port = number,
    from_port=number,
    protocol=string,
    description=string
    cidr_blocks = list(string)
  }))

  default = [ 
    {
        to_port = 22,
        from_port = 22,
        protocol = "tcp"
        description = "Allow SSH Port",
        cidr_blocks = ["172.31.0.0/16","192.168.0.0/16" ]
    },
    {
        to_port = 80,
        from_port = 80,
        protocol = "tcp"
        description = "Allow HTTP Port",
        cidr_blocks = ["0.0.0.0/0" ]
    }
  ]
}