resource "aws_ebs_volume" "wordpress-ebs" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = var.ebs_size

  tags = {
    Name = "Wordpress-ebs_as"
  }
}

resource "aws_volume_attachment" "datascientest_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.wordpress-ebs.id
  instance_id = var.ec2_id
}


