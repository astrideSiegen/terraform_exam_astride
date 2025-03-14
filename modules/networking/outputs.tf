output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.public_sn_1.id
}
output "private_subnet_ids" {
  description = "private subnet IDs"
  value       = [aws_subnet.private_sn_1.id, aws_subnet.private_sn_2.id]
}
