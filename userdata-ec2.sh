#!/bin/bash

sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
# sudo systemctl status nginx

# nginx installation part

echo 'server {
    listen 80;
    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}' | sudo tee /etc/nginx/sites-available/flask > /dev/null && \
sudo ln -s /etc/nginx/sites-available/flask /etc/nginx/sites-enabled/flask && \
sudo rm -f /etc/nginx/sites-enabled/default && \
sudo nginx -t && \
sudo systemctl reload nginx
