#!/bin/bash

# Install Apache
sudo yum install httpd -y

# Create default HTML file
sudo echo "<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Test file for ETags</title>
</head>
<body>

<h1>ETags aren't that great, but we can make it work.</h1>

</body>
</html>" > /var/www/html/index.html

# Set ETag
sudo echo "FileETag Size" >> /etc/httpd/conf/httpd.conf

# Start Apache
sudo service httpd start