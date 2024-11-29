# Server Security Setup Script

This repository contains a bash script designed to help you set up your server with essential security best practices. The script automates the process of hardening a server to secure it from common vulnerabilities and unauthorized access.

## Features

The **security setup script** includes the following features:

### 1. **System Update and Package Installation**
   - Updates the server's package list and installs security-related utilities like:
     - `ufw` (Uncomplicated Firewall)
     - `fail2ban` (Prevents brute-force attacks)
     - `unattended-upgrades` (Enables automatic security updates)
     - `curl` (Downloads files securely)

### 2. **Firewall Configuration**
   - Configures the UFW firewall to:
     - Allow **SSH** for remote access.
     - Allow **HTTP** and **HTTPS** for web access.
     - Block all other inbound connections.

### 3. **SSH Hardening**
   - **Disables root login** over SSH.
   - **Disables password authentication** for SSH and enforces SSH key-based authentication.

### 4. **Fail2Ban Setup**
   - Installs and configures **Fail2Ban**, which monitors server logs for brute-force attempts and blocks malicious IP addresses.

### 5. **Automatic Security Updates**
   - Configures the server to automatically apply security updates to minimize the risk of vulnerabilities.

### 6. **AppArmor Setup**
   - Installs **AppArmor**, a security framework that restricts programs' capabilities to limit the impact of potential exploits.

### 7. **Cleanup**
   - **Removes unnecessary packages** and frees up space on the system.

### 8. **Web Server Setup with Nginx**
   - Installs **Nginx** as the web server and configures it to serve a simple HTML page.
   - Configures **HTTPS** using **Let’s Encrypt SSL certificates** for secure communication.

### 9. **SSL Configuration**
   - Automatically sets up **Let’s Encrypt SSL certificates** for your domain.
   - Redirects HTTP traffic to HTTPS and ensures secure communication.

### 10. **File Permissions**
   - Enforces strict file permissions for sensitive directories like `/etc/ssh` and `/var/www/mywebsite` to prevent unauthorized access.

### 11. **Final Cleanup**
   - Cleans up unused packages and frees up disk space.

## Prerequisites

- Ubuntu-based server (tested on Ubuntu 20.04 and above).
- Domain name (for SSL configuration) and DNS setup pointing to your server.

## How to Use

1. **Clone the repository** or download the script:
   ```bash
   git clone https://github.com/yourusername/repository-name.git
   cd repository-name
