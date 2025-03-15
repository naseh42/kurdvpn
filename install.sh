#!/bin/bash

# Script to install Kurdan VPN Panel

echo "Starting installation of Kurdan VPN Panel..."

# Update the system
echo "Updating system..."
apt update -y && apt upgrade -y

# Install necessary packages
echo "Installing required packages..."
apt install -y python3 python3-pip python3-venv git

# Clone the Kurdan VPN Panel repository (replace with your repo URL)
echo "Cloning Kurdan VPN Panel repository..."
git clone https://github.com/yourusername/kurdvpn.git /opt/kurdvpn

# Navigate to the directory
cd /opt/kurdvpn

# Set up the virtual environment
echo "Setting up virtual environment..."
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install the Python dependencies
echo "Installing dependencies..."
pip install -r requirements.txt

# Run migrations if any
echo "Running migrations..."
# python manage.py migrate  # Uncomment if you have Django or similar migrations

# Setup environment variables (if any)
echo "Setting up environment variables..."
cp .env.example .env

# Create necessary directories or files
echo "Creating necessary directories..."
mkdir -p /opt/kurdvpn/logs
touch /opt/kurdvpn/logs/app.log

# Start the VPN panel (replace with your panel's start command)
echo "Starting the Kurdan VPN Panel..."
nohup python3 manage.py runserver &  # Replace with your start command if different

echo "Kurdan VPN Panel installation completed!"

# Exit the script
exit 0