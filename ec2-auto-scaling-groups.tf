#########################  start of web  #########################

#
# Launch configuration || "web"
#
resource "aws_launch_configuration" "lc_web" {
    name                        = "${var.aws_env}-${var.aws_name}-lc-web"
    image_id                    = "${lookup(var.aws_amazon_ecs_ami, var.aws_region)}"
    instance_type               = "${var.instance_t2_small}"
	
    enable_monitoring           = true

	 root_block_device {
         volume_size           = 30,
         volume_type           = "gp2",
         delete_on_termination = "true",
	 }

    associate_public_ip_address = "false"

    iam_instance_profile        = "${aws_iam_instance_profile.ec2.id}"
    key_name                    = "${var.key_name}"
    security_groups             = ["${aws_security_group.application.id}"]

    #user_data                   = "${data.template_file.init_web.rendered}"
}

#
# Autoscaling Group || "web"
#
resource "aws_autoscaling_group" "asg_web" {
    name                    = "${var.aws_env}-${var.aws_name}-asg-web"
    # placement_group       = "${aws_placement_group.pg_web.id}"
    launch_configuration    = "${aws_launch_configuration.lc_web.name}"
	load_balancers          = ["${var.aws_env}-${var.aws_name}-alb-web"]

    availability_zones      = ["${split(",", var.availability_zones)}"]
    vpc_zone_identifier     = ["${aws_subnet.us-east-1a-public.id}","${aws_subnet.us-east-1b-public.id}"]

    min_size                = "${var.asg_min}"
    max_size                = "${var.asg_max}"
    desired_capacity        = "${var.asg_desired}"

    health_check_grace_period = 0

    tag {
        key                 = "Name"
        value               = "${var.aws_env}-${var.aws_name}-ec2-web"
        propagate_at_launch = "true"
    }

    enabled_metrics         = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
    metrics_granularity     = "1Minute"
}

#########################  end of web  #########################