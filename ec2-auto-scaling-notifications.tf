#########################  start of web  #########################

#
# Autoscaling Notifications || "web"
#
resource "aws_autoscaling_notification" "asn_web" {
    group_names   = [
        "${aws_autoscaling_group.asg_web.name}",
    ]

    notifications = [
        "autoscaling:EC2_INSTANCE_LAUNCH",
        "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
        "autoscaling:EC2_INSTANCE_TERMINATE",
        "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
    ]

    topic_arn     = "arn:aws:sns:us-east-1:105079806215:NotifyMe"
}

#########################  end of web  #########################