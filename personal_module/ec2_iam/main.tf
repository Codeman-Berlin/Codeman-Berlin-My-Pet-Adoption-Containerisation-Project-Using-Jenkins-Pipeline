resource "aws_iam_role_policy" "ec2_policy" {
  name = var.policy
  role = aws_iam_role.ec2_role.id

  policy = "${file("./personal_module/ec2_iam/ec2-policy.json")}"
  
}

resource "aws_iam_role" "ec2_role" {
  name = var.ec2_role

  assume_role_policy = "${file("./personal_module/ec2_iam/ec2-assume.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.profile
  role = aws_iam_role.ec2_role.name
}
