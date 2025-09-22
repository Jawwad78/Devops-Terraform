
# WordPress Deployment on AWS with Terraform 

## Overview

With this project, I had to use terraform IaC to launch wordpress. Then I had to configure cloud-init for the ec2 instances instead of normal user_data

## Architecture 

The setup followed a 3 tier architecture:

* **VPC** I created 6 subnets: 2 in public, 2 in private and 2 in private db for rds
* **Bastion host** was put in public subnet for me to then ssh into private ec2 subnets (as we cant do it without 1)
* **Two EC2 instances** in private subnets running Apache, PHP, and WordPress (this makes them more safer)
* **RDS MySQL instance** in private DB subnets
* **Application Load Balancer** in public subnets forwarding the traffic from the internet to  the EC2s

**Security groups** I created security groups for all 4 :

* ALB allows HTTP and HTTPS from anywhere (so anyone on internet can acces the alb)
* Bastion allows SSH only from my IP (as we dont want other people to access it)
* App allows traffic from ALB (80/443) and Bastion (22) 
* RDS allows MySQL only from the App SG (as nothing else needs it, also used port 3306)

---


## Terraform Modules

The project is modularised into:

* **VPC**: subnets, route tables, IGW, NAT
* **EC2**: bastion + app servers with cloud-init template
* **RDS**: DB instance, subnet group, SG attachment
* **ALB**: load balancer, target group, target attachments, listeners

---

## Cloud-init for WordPress 

Before cloud-init I ran it as user_data only, but then the 2nd part of the assignment was to do it via cloud-init.
After doing some research, I realised it would be in a YAML file, so I had to read some documentation on how to do it.

When I initially done it, I was trying to do it in a list format but found it a bit confusing due to syntax, so then I switched it to a string format which was much easier.

* `packages:` this command ran the packages to install Apache and then the php extensions which Apache needed, like php-mysql for wordPress

* `runcmd:` this command actually downloaded Wordpress etc and then restarted apache.

---

## Problems I Encountered

I faced a few issues when doing this assignment, but overall it actually helped me understand it, so it was good.
The 2 main ones were:

1. **Understanding modules**
When I first done the assignment and got WordPress running, I realised that I had not put it into modules. After that I knew I had to modularise it so it was easier to understand, etc. This then really took a while as I had to understand what to reference where, and also about outputs.tf and how they output to other modules and root.

2. **User data for WordPress**
When I did the user_data, I was struggling with the commands needed to install apache and download wordpress, but then after reading a blog where someone else had previously done something similar to this, I copied the code from there which then made it easier.



## Validation and Testing

* `terraform validate` I used this to see if all the code was valid and nothing needed changing
* Full `terraform apply` actually created everything, which I then checked in the aws console and it all worked properly
* WordPress was accessible through the ALB DNS name, which I then also connected to my domain with an acm certificate for https (security)



