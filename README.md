# Test App

A simple React application that displays "It's running!" text.

## Features

- React 18 functional components
- Modern styling with gradient background and glass-morphism effects
- Responsive design
- Fast development with Vite

## Getting Started

### Prerequisites

- Node.js (version 14 or higher)
- npm or yarn

### Installation

1. Install dependencies:
```bash
npm install
```

### Development

Start the development server:
```bash
npm run dev
```

The app will be available at `http://localhost:5173`

### Building

Build the app for production:
```bash
npm run build
```

### Preview

Preview the production build:
```bash
npm run preview
```

## Project Structure

```
src/
├── App.jsx          # Main React component
├── App.css          # Component styles
└── main.jsx         # React app entry point
```

## Technologies Used

- React 18
- Vite
- CSS3 with modern features (backdrop-filter, gradients)

## AWS EC2 Deployment

### Prerequisites

- AWS EC2 instance (Ubuntu 20.04+ recommended)
- Security group allowing HTTP (port 80) and SSH (port 22)
- Key pair for SSH access

### Deployment Steps

1. **Launch EC2 Instance**:
   - Choose Ubuntu 20.04 LTS AMI
   - Select instance type (t2.micro for testing)
   - Configure security group with ports 22 (SSH) and 80 (HTTP)

2. **Connect to EC2**:
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   ```

3. **Upload Application**:
   ```bash
   scp -i your-key.pem -r . ubuntu@your-ec2-public-ip:~/test-app
   ```

4. **Run Deployment Script**:
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-public-ip
   cd ~/test-app
   chmod +x deploy.sh
   ./deploy.sh
   ```

5. **Access Application**:
   - Open browser and navigate to `http://your-ec2-public-ip`

### Manual Deployment (Alternative)

If you prefer manual setup:

```bash
# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PM2
sudo npm install -g pm2

# Build and serve
npm install
npm run build
pm2 start npm --name "test-app" -- run serve

# Install and configure nginx
sudo apt install -y nginx
sudo cp nginx.conf /etc/nginx/sites-available/test-app
sudo ln -sf /etc/nginx/sites-available/test-app /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
```

### Production Considerations

- **Domain & SSL**: Use Route 53 for domain and Certificate Manager for SSL
- **Load Balancer**: Use ALB for multiple instances
- **Auto Scaling**: Configure ASG for high availability
- **Monitoring**: Use CloudWatch for logs and metrics
- **Security**: Regular updates, proper IAM roles, VPC configuration
