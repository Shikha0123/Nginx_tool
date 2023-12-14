output "Instance_id_public" {
    value = aws_instance.bastion[*].id
}
output "Instance_id_private" {
    value = aws_instance.private-ec2[*].id
}