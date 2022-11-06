output "public_subnet" {
    value = "aws_subnet.public_subnet[*].id"  
}
output "azs" {
    value = "aws_availability_zones.web[*].id"
}