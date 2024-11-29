
#!/bin/bash

# Step 1: Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install Nginx, Certbot (for SSL), and other necessary tools
echo "Installing Nginx and Certbot..."
sudo apt install -y nginx certbot python3-certbot-nginx

# Step 3: Set up a simple HTML website
echo "Creating sample website content..."
sudo mkdir -p /var/www/mywebsite
echo "<html><head><title>Welcome to My Website</title></head><body><h1>Hello, World! This is a sample website.</h1></body></html>" | sudo tee /var/www/mywebsite/index.html > /dev/null

# Step 4: Configure Nginx for the website
echo "Configuring Nginx server block for the website..."
sudo bash -c 'cat > /etc/nginx/sites-available/mywebsite <<EOF
server {
    listen 80;
    server_name <your-domain.com>;

    root /var/www/mywebsite;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # SSL Redirection
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/<your-domain.com>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<your-domain.com>/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-RSA-AES128-GCM-SHA256';
    ssl_prefer_server_ciphers on;

    # Security headers
    add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload' always;
    add_header X-Content-Type-Options 'nosniff' always;
    add_header X-Frame-Options 'DENY' always;
    add_header X-XSS-Protection '1; mode=block' always;

    # Logging
    access_log /var/log/nginx/mywebsite_access.log;
    error_log /var/log/nginx/mywebsite_error.log;
}
EOF'

# Step 5: Enable the site and test Nginx configuration
echo "Enabling site and testing Nginx configuration..."
sudo ln -s /etc/nginx/sites-available/mywebsite /etc/nginx/sites-enabled/
sudo nginx -t

# Step 6: Reload Nginx to apply changes
echo "Reloading Nginx..."
sudo systemctl reload nginx

# Step 7: Set up SSL using Certbot (Let's Encrypt)
echo "Setting up SSL using Certbot..."
sudo certbot --nginx -d <your-domain.com> --agree-tos --no-eff-email --redirect --hsts --staple-ocsp --email <your-email>

# Step 8: Set up automatic SSL renewal
echo "Setting up automatic SSL renewal..."
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer

# Step 9: Firewall Configuration - Allow HTTP and HTTPS traffic
echo "Configuring UFW firewall..."
sudo ufw allow 'Nginx Full'

# Step 10: Clean up and remove unnecessary packages
echo "Cleaning up the system..."
sudo apt autoremove -y
sudo apt clean

# Step 11: Print confirmation
echo "Website setup complete!"
echo "Your website is now available at https://<your-domain.com>."
echo "Nginx is configured with SSL, and automatic SSL renewal is enabled."
