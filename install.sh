#!/bin/bash

# Function to install required packages
install_packages() {
    echo "Updating and installing required packages..."
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y git python3 python3-pip python3-venv
}

# Function to clone the repository
clone_repository() {
    echo "Cloning the Kurdan VPN Panel repository..."
    if [ ! -d "/opt/kurdvpn" ]; then
        git clone https://github.com/naseh42/kurdvpn.git /opt/kurdvpn
    else
        echo "Repository already cloned in /opt/kurdvpn. Skipping clone."
    fi
}

# Function to create and activate virtual environment
create_virtualenv() {
    echo "Creating and activating virtual environment..."
    cd /opt/kurdvpn
    if [ ! -d "venv" ]; then
        python3 -m venv venv
    fi
    source venv/bin/activate
}

# Function to install dependencies from requirements.txt
install_requirements() {
    echo "Installing Python dependencies..."
    if [ ! -f "requirements.txt" ]; then
        echo "requirements.txt not found. Creating it from current environment."
        pip freeze > requirements.txt
    fi
    pip install -r requirements.txt
}

# Function to create .env file with default values
create_env_file() {
    echo "Creating .env file with default values..."
    if [ ! -f ".env" ]; then
        cat <<EOL > .env
# Database Configuration
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=kurdvpn_db

# Secret Key for encryption (change this to a random value)
SECRET_KEY=$(openssl rand -base64 32)

# Other configurations (modify based on your requirements)
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
EOL
        echo ".env file created successfully."
    else
        echo ".env file already exists. Skipping creation."
    fi
}

# Function to create necessary directories
create_directories() {
    echo "Creating necessary directories..."
    mkdir -p /opt/kurdvpn/logs
    mkdir -p /opt/kurdvpn/data
    mkdir -p /opt/kurdvpn/uploads
}

# Function to run database migrations
run_migrations() {
    echo "Running database migrations (if applicable)..."
    # Uncomment and modify the line below if you have Django or another framework that needs migrations
    # python3 manage.py migrate
    echo "Migrations completed (if applicable)."
}

# Function to start the Kurdan VPN Panel
start_vpn_panel() {
    echo "Starting Kurdan VPN Panel..."
    nohup python3 app.py & # Replace app.py with the appropriate start script
    echo "Kurdan VPN Panel started successfully."
}

# Main installation process
install_packages
clone_repository
create_virtualenv
install_requirements
create_env_file
create_directories
run_migrations
start_vpn_panel

echo "Installation completed successfully!"
