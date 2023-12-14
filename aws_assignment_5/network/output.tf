output "vpc_id" {
    value = aws_vpc.tem_vpc.id
}
output "vpc_id_print" {
    value = aws_vpc.tem_vpc[*].id
}

output "pub_subnet_id" {
    value = aws_subnet.public[*].id
}
output "pri_subnet_id" {
    value = aws_subnet.private[*].id
}