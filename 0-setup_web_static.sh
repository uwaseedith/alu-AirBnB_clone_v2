#!/usr/bin/env bash
# describe it then
apt-get update
apt-get -y install nginx

directories=("/data/web_static/releases/test" "/data/web_static/shared/")

for directory in "${directories[@]}"; do
  #  if [ ! -e "$directory" ]; then
  mkdir -p "$directory"
  #  fi
done

echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >/data/web_static/releases/test/index.html

# Create a symbolic link /data/web_static/current linked to the /data/web_static/releases/test/ folder.
# If the symbolic link already exists, it should be deleted and recreated every time the script is ran
ln --symbolic --force /data/web_static/releases/test /data/web_static/current

# The -R option ensures that the ownership changes are applied
# recursively to all files and directories within the folder
chown -R ubuntu:ubuntu /data/

sed -i '/listen 80 default_server;/a \ \n    location /hbnb_static {\n        alias /data/web_static/current/;\n        index index.html;\n    }' /etc/nginx/sites-available/default

service nginx restart
