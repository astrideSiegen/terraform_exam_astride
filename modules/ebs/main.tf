resource "aws_ebs_volume" "wordpress-ebs" {
  availability_zone = var.availability_zone[0]
  size              = var.ebs_size

  tags = {
    Name = "Wordpress-ebs"
  }
}

resource "aws_volume_attachment" "datascientest_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.wordpress-ebs
  instance_id = aws_instance.datascientest-instance.id
}
