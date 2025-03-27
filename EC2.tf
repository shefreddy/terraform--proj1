#Launch Template for EC2 Instances
resource "aws_launch_template" "app" {
    name_prefix = "app-launch-template"
    image_id = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI ID 
    instance_type = "t2.micro"

    network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.instance_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              # Update the instance and install necessary packages
              yum update -y
              yum install -y httpd wget unzip
              
              # Start Apache and enable it to start on boot
              systemctl start httpd
              systemctl enable httpd
              
              # Navigate to the web root directory
              cd /var/www/html
              
              # Download a CSS template directly
              wget https://www.free-css.com/assets/files/free-css-templates/download/page284/built-better.zip
              
              # Unzip the template and move the files to the web root
              unzip built-better.zip -d /var/www/html/
              mv /var/www/html/html/* /var/www/html/
              
              # Clean up unnecessary files
              rm -r /var/www/html/html
              rm built-better.zip
              
              # Restart Apache to apply changes
              systemctl restart httpd
              EOF
  )
  
}