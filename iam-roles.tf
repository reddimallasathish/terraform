#
# ECS Instance Role
#
resource "aws_iam_role" "ecs_instance_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsInstanceRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

#
# ECS Service Role
#
resource "aws_iam_role" "ecs_service_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsServiceRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

#
# ECS Container Service Task Role
#
resource "aws_iam_role" "ecs_tasks_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsTasksRole"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

#
# ECS Container Service Autoscaling Role
#
resource "aws_iam_role" "ecs_service_autoscaling_role" {
    name = "${var.aws_env}-${var.aws_name}-ecsServiceAutoscalingRole"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "application-autoscaling.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


#
# Custom Policy - AmazonEC2ContainerServiceforEC2Role
#
resource "aws_iam_policy" "ec2_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceforEC2Role"
    description = "Custom Policy - Amazon EC2 Role for Amazon EC2 Container Service."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:CreateCluster",
                "ecs:DeregisterContainerInstance",
                "ecs:DiscoverPollEndpoint",
                "ecs:Poll",
                "ecs:RegisterContainerInstance",
                "ecs:StartTelemetrySession",
                "ecs:UpdateContainerInstancesState",
                "ecs:Submit*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonEC2ContainerServiceRole
#
resource "aws_iam_policy" "ecs_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceRole"
    description = "Custom Policy - Amazon ECS service role."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:Describe*",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:Describe*",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:RegisterTargets"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonEC2RoleforSSM
#
resource "aws_iam_policy" "ssm_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2RoleforSSM"
    description = "Custom Policy - Amazon EC2 Role for Simple Systems Manager service role."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ds:CreateComputer",
                "ds:DescribeDirectories"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts",
                "s3:ListBucketMultipartUploads"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": "arn:aws:s3:::amazon-ssm-packages-*"
        }
    ]
}
EOF
}

#
# Custom Policy - AutoScalingFullAccess
#
resource "aws_iam_policy" "as_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AutoScalingFullAccess"
    description = "Custom Policy - Full access to Auto Scaling."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:PutMetricAlarm",
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonEC2ContainerServiceAutoscaleRole
#
resource "aws_iam_policy" "sas_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonEC2ContainerServiceAutoscaleRole"
    description = "Custom Policy - Enable Task Autoscaling for Amazon EC2 Container Service."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeServices",
                "ecs:UpdateService"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarms"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonS3ReadOnlyAccess
#
resource "aws_iam_policy" "s3_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonS3ReadOnlyAccess"
    description = "Custom Policy - Read only access to all S3 buckets."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - CloudWatchLogsFullAccess
#
resource "aws_iam_policy" "cwl_policy" {
    name        = "${var.aws_env}-${var.aws_name}-CloudWatchLogsFullAccess"
    description = "Custom Policy - Full access to CloudWatch Logs."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

#
# Custom Policy - AmazonSNSReadOnlyAccess
#
resource "aws_iam_policy" "sns_policy" {
    name        = "${var.aws_env}-${var.aws_name}-AmazonSNSReadOnlyAccess"
    description = "Custom Policy - Read only access to all SNS topics."

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:GetTopicAttributes",
                "sns:List*",
                "sns:Publish",
                "sns:Subscribe"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


#
# Policy Attachments to AmazonEC2ContainerServiceforEC2Role
#
resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-ec2-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.name}"
    ]

    policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

#
# Policy Attachments to AmazonEC2ContainerServiceRole
#
resource "aws_iam_policy_attachment" "ecs_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-ecs-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_role.name}"
    ]

    policy_arn = "${aws_iam_policy.ecs_policy.arn}"
}

#
# Policy Attachments to AmazonEC2RoleforSSM
#
resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-ssm-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.name}",
        "${aws_iam_role.ecs_service_role.name}"
    ]

    policy_arn = "${aws_iam_policy.ssm_policy.arn}"
}

#
# Policy Attachments to AutoScalingFullAccess
#
resource "aws_iam_policy_attachment" "as_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-as-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_role.id}"
    ]

    policy_arn = "${aws_iam_policy.as_policy.arn}"
}

#
# Policy Attachments to AmazonEC2ContainerServiceAutoscaleRole
#
resource "aws_iam_policy_attachment" "sas_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-sas-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_service_autoscaling_role.id}"
    ]

    policy_arn = "${aws_iam_policy.sas_policy.arn}"
}

#
# Policy Attachments to AmazonS3ReadOnlyAccess
#
resource "aws_iam_policy_attachment" "s3_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-s3-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.id}",
        "${aws_iam_role.ecs_service_role.id}",
        "${aws_iam_role.ecs_tasks_role.id}",
    ]

    policy_arn = "${aws_iam_policy.s3_policy.arn}"
}

#
# Policy Attachments to CloudWatchLogsFullAccess
#
resource "aws_iam_policy_attachment" "cwl_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-cwl-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.id}",
        "${aws_iam_role.ecs_service_role.id}",
        "${aws_iam_role.ecs_tasks_role.id}",
        "${aws_iam_role.ecs_service_autoscaling_role.id}",
    ]

    policy_arn = "${aws_iam_policy.cwl_policy.arn}"
}

#
# Policy Attachments to AmazonSNSReadOnlyAccess
#
resource "aws_iam_policy_attachment" "sns_policy_attachment" {
    name  = "${var.aws_env}-${var.aws_name}-sns-policy-attachment"

    roles = [
        "${aws_iam_role.ecs_instance_role.id}",
        "${aws_iam_role.ecs_service_role.id}",
        "${aws_iam_role.ecs_tasks_role.id}",
        "${aws_iam_role.ecs_service_autoscaling_role.id}",
    ]

    policy_arn = "${aws_iam_policy.sns_policy.arn}"
}
