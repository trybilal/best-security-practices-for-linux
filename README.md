#1. System Update and Package Installation
Updates the system: The script updates your server’s package list and upgrades any outdated packages to their latest versions.
Installs essential security tools: It installs important security utilities like ufw (Uncomplicated Firewall), fail2ban (for brute-force attack prevention), unattended-upgrades (for automatic security updates), and curl (for downloading files over HTTP/HTTPS).
#2. Firewall Setup with UFW
Configures UFW firewall to only allow inbound traffic on essential ports:
SSH (for remote access)
HTTP (for web access)
HTTPS (for secure web access)
All other ports are blocked by default to ensure a minimal attack surface.
#3. SSH Security
Disables root login over SSH for added security.
Disables password authentication for SSH and enforces the use of SSH keys for secure logins.
#4. Fail2Ban Installation
Installs and enables Fail2Ban, a tool that monitors log files for malicious activity and blocks IP addresses that show signs of brute-force attacks.
#5. Automatic Security Updates
Configures the server to automatically apply security updates to prevent vulnerabilities due to outdated software.
#6. SSH Key-Based Authentication Setup
Prompts to set up SSH key-based authentication. This is a more secure way to authenticate users, preventing unauthorized login attempts via password guessing.
#7. AppArmor Installation
Installs and configures AppArmor, a security module for Linux that helps restrict the capabilities of running programs, reducing the risk of privilege escalation.
#8. Cleanup of Unnecessary Packages
Removes unused packages and frees up system space by using the apt autoremove and apt clean commands.
#9. Nginx Web Server Installation
Installs Nginx as a web server.
Configures Nginx to serve a simple HTML page as a placeholder for your website.
Configures Nginx to listen on port 80 (HTTP) and sets up the server block for your domain.
#10. SSL/TLS Configuration
Installs Let’s Encrypt SSL certificates for HTTPS support. This ensures encrypted communication between the server and clients.
Configures Nginx to use the SSL certificate, redirecting all HTTP traffic to HTTPS automatically.
Sets up automatic SSL certificate renewal via certbot.
#11. File Permissions
Sets secure file permissions for critical directories like /etc/ssh and /var/www/mywebsite to prevent unauthorized access.
#12. Firewall Rules for Nginx
Configures the firewall to allow traffic on HTTP and HTTPS ports, which are required for web access.
#13. Final Cleanup
Cleans up any unused or unnecessary packages from the system to maintain optimal performance.
#Outcome
By running this script, your server will be configured with:

Strong security settings for SSH access.
Firewall rules that only permit essential traffic.
Automated updates and regular security patches.
A simple public website served by Nginx with SSL encryption (HTTPS).
#This script provides a secure base configuration for a server, ensuring essential services are hardened, unnecessary services are removed, and the server is protected from common attack vectors.
