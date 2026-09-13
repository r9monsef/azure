#!/bin/bash

set -e

WEBROOT="/var/www/nginx-learning"
NGINX_CONF="/etc/nginx/conf.d/nginx-learning.conf"

# Read hostname dynamically
HOSTNAME_ACTUAL=$(hostname)

echo "Installing nginx..."
apt update -y
apt install nginx -y
rm -f /etc/nginx/sites-enabled/default
echo "Creating web root..."
mkdir -p "$WEBROOT"

echo "Creating HTML pages..."

# Root page
cat <<EOF > "$WEBROOT/index.html"
<html>
<head>
    <title>Nginx</title>
</head>
<body>
    <h1>Welcome to nginx on $HOSTNAME_ACTUAL</h1>
</body>
</html>
EOF

# Images page
cat <<EOF > "$WEBROOT/images.html"
<html>
<head>
    <title>Images</title>
</head>
<body>
    <h1>Welcome to images on $HOSTNAME_ACTUAL</h1>
</body>
</html>
EOF

# Shops page
cat <<EOF > "$WEBROOT/shops.html"
<html>
<head>
    <title>Shops</title>
</head>
<body>
    <h1>Welcome to shops on $HOSTNAME_ACTUAL</h1>
</body>
</html>
EOF

echo "Creating nginx config..."


sudo tee /etc/nginx/conf.d/nginx-learning.conf > /dev/null <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    root /var/www/nginx-learning;

    location = / {
        index index.html;
    }

    location = /images {
        try_files /images.html =404;
    }

    location = /shops {
        try_files /shops.html =404;
    }
}
EOF
sudo chown -R www-data:www-data /var/www/nginx-learning
sudo chmod -R 755 /var/www/nginx-learning


echo "Testing nginx configuration..."
nginx -t

echo "Reloading nginx..."
systemctl enable nginx
systemctl restart nginx

echo "Done."
echo "Test URLs:"
echo "http://SERVER-IP/"
echo "http://SERVER-IP/images"
echo "http://SERVER-IP/shops"
