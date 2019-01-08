resource "aws_elb" "load_balancer_web" {
  name               = "${var.aws_env}-${var.aws_name}-alb-web"
  subnets            = ["${aws_subnet.us-east-1a-public.id}","${aws_subnet.us-east-1b-public.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  tags = {
    Name = "${var.aws_env}-${var.aws_name}-alb-web"
  }
}