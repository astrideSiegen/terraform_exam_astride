
output "ebs_id" {
  value = aws_ebs_volume.wordpress-ebs.id
}
# output "first_az" {
#   value = data.aws_availability_zones.available.names[0]
# }

# output "second_az" {
#   value = data.aws_availability_zones.available.names[1]
# }


