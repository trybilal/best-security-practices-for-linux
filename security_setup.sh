
#!/bin/bash

# Step 1: Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install necessary tools
echo "Installing necessary security tools..."
sudo apt install -y ufw fail2ban fail2ban-common unattended-upgrades apt-transport-https curl gnupg2 ca-certificates lsb-release

# Step 3: Set up UFW firewall (only allow necessary ports)
echo "Setting up UFW firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Step 4: Disable root login and password authentication for SSH
echo "Disabling root login and password authentication for SSH..."
sudo sed -i 's/^PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl reload sshd

# Step 5: Install and configure Fail2Ban
echo "Installing and configuring Fail2Ban..."
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Step 6: Set up automatic security updates
echo "Setting up automatic security updates..."
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Step 7: Set up SSH key-based authentication
echo "Setting up SSH key-based authentication..."
echo "Make sure to add your public key to the server's ~/.ssh/authorized_keys file."

# Step 8: Configure AppArmor or SELinux (Choose one based on the distro)
echo "Configuring AppArmor..."
sudo apt install -y apparmor apparmor-utils
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Step 9: Clean up unnecessary packages and free up space
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y
sudo apt clean

# Step 10: Install and configure Nginx with HTTPS (Let’s Encrypt SSL)
echo "Installing and configuring Nginx with HTTPS..."
sudo apt install -y nginx certbot python3-certbot-nginx

# Step 11: Set up a simple sample website
echo "Setting up a sample website..."
sudo mkdir -p /var/www/mywebsite
echo "<html><head><title>Welcome to My Secure Website</title></head><body><h1>Hello, World!</h1></body></html>" | sudo tee /var/www/mywebsite/index.html > /dev/null

# Step 12: Configure Nginx
echo "Configuring Nginx..."
sudo bash -c 'cat > /etc/nginx/sites-available/mywebsite <<EOF
server {
    listen 80;
    server_name <your-domain.com>;

    root /var/www/mywebsite;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

sudo ln -s /etc/nginx/sites-available/mywebsite /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

# Step 13: Set up SSL with Let’s Encrypt
echo "Setting up SSL with Let’s Encrypt..."
sudo certbot --nginx -d <your-domain.com> --agree-tos --no-eff-email --redirect --hsts --staple-ocsp --email <your-email>

# Step 14: Set up automatic SSL renewal
echo "Setting up automatic SSL renewal..."
sudo systemctl enable certbot.timer
sudo systemctl start certbot.timer

# Step 15: Firewall configuration for Nginx
echo "Configuring firewall to allow HTTP and HTTPS..."
sudo ufw allow 'Nginx Full'

# Step 16: Security Hardening - File Permissions
echo "Setting file permissions..."
sudo chmod -R 700 /etc/ssh /var/www/mywebsite

# Step 17: Final Cleanup
echo "Cleaning up unnecessary packages..."
sudo apt autoremove -y
sudo apt clean

# Step 18: Print confirmation message
echo "Server setup complete! Your server is now secured with a firewall, SSH key authentication, Fail2Ban, and HTTPS."
