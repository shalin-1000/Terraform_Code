variable "availability_zones" {
  type = list(string)

}

variable "Linux_ami" {
  type = map(any)
  default = {
    "ap-south-1" : "ami-0f5ee92e2d63afc18"
  }
}

variable "region" {
  type = string

}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string

}
