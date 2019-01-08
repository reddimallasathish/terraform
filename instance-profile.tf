#
# Instance Profile
#
resource "aws_iam_instance_profile" "ec2" {
    name = "${var.aws_env}-${var.aws_name}-instance-profile2"
    role = "${aws_iam_role.ecs_instance_role.name}"
}
