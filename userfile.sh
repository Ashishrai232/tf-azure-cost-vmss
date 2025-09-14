#!/bin/bash


# Install nginx if not installed
sudo apt-get install -y nginx

# Clone the repo (if directory exists, remove it first)
if [ -d "sandbox" ]; then
    rm -rf sandbox
fi

git clone https://github.com/Ashishrai232/sandbox.git

# Copy static-web contents to nginx web root
sudo cp -r sandbox/static-web/* /var/www/html/

# Ensure proper permissions
sudo chown -R www-data:www-data /var/www/html/

# Start nginx service (or restart to apply changes)
sudo systemctl restart nginx

echo "Setup complete. Website should be live on port 80."
