#!/bin/bash
cd /etc/nginx/sites-enabled
rm default
cd ../sites-available

cat << EOF > ghost
server {
    listen 0.0.0.0:80;
    server_name ghost;
    access_log /var/log/nginx/ghost.log;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header HOST $http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_pass http://127.0.0.1:2368;
        proxy_redirect off;
    }
}
EOF

cd ..
ln -s sites-available/ghost sites-enabled/ghost

cd /ghost
npm start
~             