
# WordPress Deployment on AWS with Terraform 🌍

## Overview

This project sets up a full WordPress environment on AWS using **Terraform** and **Cloud-init**. The goal was to build and automate a real world style setup with separate modules, so that WordPress is ready to run as soon as the servers start.


## Architecture 🏗️

The setup follows a three-tier architecture:

* **VPC** with 6 subnets across 2 AZs (public, private app, private DB)
* **Bastion host** in a public subnet for SSH access
* **Two EC2 instances** in private subnets running Apache, PHP, and WordPress
* **RDS MySQL instance** in private DB subnets
* **Application Load Balancer** in public subnets forwarding traffic to EC2s

**Security groups** were created for each layer:

* ALB allows HTTP and HTTPS from anywhere
* Bastion allows SSH only from my IP
* App allows traffic from ALB (80/443) and Bastion (22)
* RDS allows MySQL only from the App SG

---

## Terraform Modules

The project is modularised into:

* **VPC**: subnets, route tables, IGW, NAT
* **EC2**: bastion + app servers with cloud-init template
* **RDS**: DB instance, subnet group, SG attachment
* **ALB**: load balancer, target group, target attachments, listeners

---

## Cloud-init for WordPress ⚙️

I replaced plain Bash user data with a **cloud-init YAML** template.

* `packages:` installs Apache and all required PHP extensions
* `runcmd:` downloads WordPress, sets ownership, permissions, and restarts Apache

---

## Problems I Encountered ❗

I faced many issues and it really made me learn,  but these three were the biggest:

1. **Understanding modules**
   At the start I didn’t really understand how Terraform modules worked. I was writing everything in one place and it got messy. Once I learned how to split resources into proper modules for VPC, EC2, RDS, and ALB, the whole project became much cleaner and easier to manage.

2. **User data for WordPress**
  Getting WordPress to install automatically was a real challenge. At first I used a plain Bash script inside user data, then I struggled to switch it into cloud-init YAML. With the documentation and some trial and error I finally got it working using packages: and runcmd

3. **Private EC2s had no internet** My NAT Gateway had no Elastic IP, and my Bastion SG was restricted to outbound 22 only. This stopped updates and WordPress bootstrap. Assigning an Elastic IP and fixing outbound rules solved it.
---

## Validation and Testing

* `terraform validate` passed without errors
* Full `terraform apply` created the environment successfully
* WordPress was accessible through the **ALB DNS name**
* Connected a domain with ACM certificate → worked over HTTPS

---

## Key Learnings 📚

* How to properly modularise infrastructure (VPC, EC2, RDS, ALB)
* Correct use of **Cloud-init** with Terraform variable injection
* Debugging AWS networking and outputs when things fail
* Importance of clear outputs for inter-module connections

