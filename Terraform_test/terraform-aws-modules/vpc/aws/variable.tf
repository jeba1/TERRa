variable "vpc_cidr" {
  default = "10.252.0.0/16"
}
variable "enable_nat_gateway" {
    type = boolean
    default = {}
}
variable "name" {
    type = boolean
    defualt = {}
}
variable "enable_dns_hostnames" {
    type = boolean
    default = {}
}
variable "enable_dns_support" {
    type = boolean
    default = {}
}
variable "vpc_cidr" {
    default = {}
}
variable "availability_zone " {
  default = {}
}