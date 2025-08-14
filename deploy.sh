#!/bin/bash

# Deployment script for AWS EC2
# Run this script on your EC2 instance

set -e

echo "🚀 Starting deployment..."

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2 for process management
sudo npm install -g pm2

# Install nginx
sudo apt install -y nginx

# Create app directory
sudo mkdir -p /var/www/test-app
sudo chown $USER:$USER /var/www/test-app

# Copy application files (assumes you've uploaded them to ~/test-app)
cp -r ~/test-app/* /var/www/test-app/

# Navigate to app directory
cd /var/www/test-app

# Install dependencies
npm install

# Build the application
npm run build

# Start the application with PM2
pm2 start npm --name "test-app" -- run serve

# Save PM2 configuration
pm2 save
pm2 startup

# Copy nginx configuration
sudo cp nginx.conf /etc/nginx/sites-available/test-app
sudo ln -sf /etc/nginx/sites-available/test-app /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Test nginx configuration
sudo nginx -t

# Restart nginx
sudo systemctl restart nginx

# Enable services on boot
sudo systemctl enable nginx

echo "✅ Deployment completed!"
echo "🌐 Your app should be available at http://your-ec2-public-ip"