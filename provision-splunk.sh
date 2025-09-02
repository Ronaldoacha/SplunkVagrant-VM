#!/bin/bash
#########################################
# Update system
echo "Updating system packages..."
apt install ne
#########################################
# Install dependencies
echo "Installing dependencies..."
apt install -y wget
#########################################
# Download Splunk
echo "Downloading Splunk..."
wget -O /tmp/splunk.tgz "https://download.splunk.com/products/splunk/releases/9.1.2/linux/splunk-9.1.2-b6b9c8185839-Linux-x86_64.tgz"
#########################################
# Extract Splunk
echo "Extracting Splunk..."
tar -xzvf /tmp/splunk.tgz -C /opt
#########################################
# Create splunk user
echo "Creating splunk user..."
useradd -r -d /opt/splunk splunk
chown -R splunk:splunk /opt/splunk
#########################################
# Set up all configuration files BEFORE starting
echo "Configuring Splunk files..."
#########################################
# Create user-seed.conf for admin credentials
cat > /opt/splunk/etc/system/local/user-seed.conf << EOL
[user_info]
USERNAME = admin
PASSWORD = Admin2020@
EOL
#########################################
# Create inputs.conf to disable some initial setup
cat > /opt/splunk/etc/system/local/inputs.conf << EOL
[default]
host = vagrant-splunk

[tcp://9997]
disabled = 1
EOL
#########################################
# Set proper permissions
chown -R splunk:splunk /opt/splunk/etc/
#########################################
# Start Splunk with all non-interactive flags
echo "Starting Splunk..."
sudo -u splunk /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd Admin2020@
#########################################
# Enable boot start
echo "Enabling boot start..."
sudo -u splunk /opt/splunk/bin/splunk enable boot-start -user splunk --answer-yes --no-prompt
######################################### "SplunkUser info"#########################################
echo "=============================================="
echo "Splunk installation completed!"
echo "Access at: http://localhost:8001"
echo "Username: admin"
echo "Password: Admin2020@"
echo "=============================================="