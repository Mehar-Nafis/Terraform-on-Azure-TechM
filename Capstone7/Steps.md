Format the configuration
```
terraform fmt
```
Correct a variable interpolation error
In main.tf, find the aws_instance.web_app resource's tags attribute on line 46. The Name tag is incorrectly formatted. It is trying to append a string to the name input variable without the necessary interpolation syntax. Update the Name attribute with the correct syntax.
tags = {
    - Name = $var.name-learn
    +  Name = "${var.name}-learn"
    }
```
terraform fmt
```

Validate your configuration
```
terraform init
```
```
terraform validate
```
Correct a cycle error
Your aws_security_group resources reference one another in their security_groups attributes. AWS cannot create the security groups because their configurations each reference the other group, which would not exist yet.

Remove the mutually dependent security group rules in your configuration, leaving the two group resources without ingress attributes.
resource "aws_security_group" "sg_ping" {
   name = "Allow Ping"

  **ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.sg_8080.id]
  }**
 }

 resource "aws_security_group" "sg_8080" {
   name = "Allow 8080"

 resource "aws_security_group" "sg_ping" {
   name = "Allow Ping"

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.sg_8080.id]
  }
 }

 resource "aws_security_group" "sg_8080" {
   name = "Allow 8080"

  **ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ping.id]
  }**
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
 Add the new, independent rule resource configurations to main.tf.
 resource "aws_security_group_rule" "allow_ping" {
    type = "ingress"
    from_port = -1
    to_port = -1
    protocol = "icmp"
    security_group_id = aws_security_group.sg_ping.id
    source_security_group_id = aws_security_group.sg_8080.id
}

resource "aws_security_group_rule" "allow_8080" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.sg_8080.id
    source_security_group_id = aws_security_group.sg_ping.id
}
```
terraform validate
```
Correct a for_each error
In main.tf, on line 44, replace the value of the for_each attribute with a local value. On line 47, replace the vpc_security_group_ids value with the value from the for_each attribute. Finally, update the tags attribute to give each instance a unique name.
resource "aws_instance" "web_app" {
 - for_each               = aws_security_group.*.id
+ for_each               = local.security_groups
   ami                    = data.aws_ami.ubuntu.id
   instance_type          = "t2.micro"
- vpc_security_group_ids = [each.id]
+  vpc_security_group_ids = [each.value]
   user_data              = <<-EOF
               #!/bin/bash
               apt-get update
               apt-get install -y apache2
               sed -i -e 's/80/8080/' /etc/apache2/ports.conf
               echo "Hello World" > /var/www/html/index.html
               systemctl restart apache2
               EOF
   tags = {
 -  Name = "${var.name}-learn"
 +  Name = "${var.name}-learn-${each.key}"
   }
 }
}
Define the local value in your main.tf file. This converts the list of security groups to a map
locals {
  security_groups = {
    sg_ping   = aws_security_group.sg_ping.id,
    sg_8080   = aws_security_group.sg_8080.id,
  }
}
```
terraform fmt
```

```
terraform validate
```
Correct your outputs to return all values
Open outputs.tf and update the output values with the for expression.
 output "instance_id" {
   description = "ID of the EC2 instance"
-   value       = aws_instance.web_app.id
+   value       = [for instance in aws_instance.web_app: instance.id]
 }

 output "instance_public_ip" {
   description = "Public IP address of the EC2 instance"
-   value       = aws_instance.web_app.public_ip
+   value       = [for instance in aws_instance.web_app: instance.public_ip]
 }

output "instance_name" {
   description = "Tags of the EC2 instance"
-  value        = aws_instance.web_app.tags
+  value        = [for instance in aws_instance.web_app: instance.tags.Name]
}
```
terraform fmt
```
```
terraform validate
```

```
terraform apply
```

Confirm versioning
```
terraform version
```

Enable Terraform logging
```
export TF_LOG_CORE=TRACE
```
```
export TF_LOG_PROVIDER=TRACE
```
```
export TF_LOG_PATH=logs.txt
```
To generate an example of the core and provider logs, run a terraform refresh operation.
```
terraform refresh
```

Open and review the logs.txt file. This log file contains both provider.terraform-provider-aws and Terraform core logging.
```
cat logs.txt
```

Clean up resources
```
terraform destroy
```
