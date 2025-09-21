resource "aws_lb" "aws_alb_test" {
  name               = "alb-tf"
  internal           = false #this means the alb is facing the internet so we can access it 
  load_balancer_type = "application" #we want application load balancer
  subnets  = [ var.public_subnet_1, var.public_subnet_2] #put it in public AZs
  security_groups =  [var.alb_sg_id] #configure the SGs

  enable_deletion_protection = false #to save deleting the ALB, change to false if ALB needs deleting

  tags = {
    Name = "ALB"
  }
}

#creat target group so alb can target the  target group
resource "aws_lb_target_group" "target_ec2" {
  port     = var.http
  protocol = "HTTP"
  vpc_id   = var.aws_vpc_id
  
}

#attaching the ec2's to the target group
#this is for first ec2
resource "aws_lb_target_group_attachment" "ec2_alb_attach" {
  target_group_arn = aws_lb_target_group.target_ec2.arn
  target_id        = var.first_app_ec2
  port             = var.http
}

#this is for second ec2
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn   = aws_lb_target_group.target_ec2.arn
  target_id          = var.second_app_ec2
  port               = var.http
}

#Creating a listner so it can forward the alb to target groups, port 443 fo https
resource "aws_lb_listener" "front_end_443" {
  load_balancer_arn = aws_lb.aws_alb_test.arn
  port              = var.https
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  #now adding my domain name which i have configured in aws for ssl 
  certificate_arn   = "arn:aws:acm:eu-west-2:726661503364:certificate/b37fc1ee-159e-4929-83ea-73c953a16683" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_ec2.arn
  }
}

#Creating a listner so it can forward the alb to target groups,port 80 for http
resource "aws_lb_listener" "front_end_80" {
  load_balancer_arn = aws_lb.aws_alb_test.arn
  port              = var.http
  protocol          = "HTTP"
  #dont need the ssl policy here
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_ec2.arn
  }
}
