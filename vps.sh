#!/bin/bash
#make the vps management script available to the root user
echo "alias vps='/root/vps/site_create.sh'" >> /root/.bashrc

#vim setup
cd /root
touch .vimrc
echo "let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
syntax on
colorscheme industry
set tabstop=4 shiftwidth=4 expandtab" > .vimrc
#Nginx setup
apt update -y
apt install nginx -y
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
#in the http{ } block, first line, add the following:
#include /etc/nginx/sites-enabled/*;
echo "user nginx;" > /etc/nginx/nginx.conf
echo "worker_processes 1;" >> /etc/nginx/nginx.conf
echo "error_log /var/log/nginx/error.log warn;" >> /etc/nginx/nginx.conf
echo "pid /var/run/nginx.pid;" >> /etc/nginx/nginx.conf
echo "events {" >> /etc/nginx/nginx.conf
echo "worker_connections 1024;" >> /etc/nginx/nginx.conf
echo "}" >> /etc/nginx/nginx.conf
echo "http {" >> /etc/nginx/nginx.conf
echo "include /etc/nginx/mime.types;" >> /etc/nginx/nginx.conf
echo "include /etc/nginx/sites-enabled/*;" >> /etc/nginx/nginx.conf
echo "default_type application/octet-stream;" >> /etc/nginx/nginx.conf
echo "log_format main '\$remote_addr - \$remote_user [\$time_local] "\$request" ' " >> /etc/nginx/nginx.conf
echo "                '\$status \$body_bytes_sent "\$http_referer" '" >> /etc/nginx/nginx.conf
echo "                '"\$http_user_agent" "\$http_x_forwarded_for"' " >> /etc/nginx/nginx.conf
echo "access_log /var/log/nginx/access.log main;" >> /etc/nginx/nginx.conf
echo "sendfile on;" >> /etc/nginx/nginx.conf
echo "#tcp_nopush on;" >> /etc/nginx/nginx.conf
echo "keepalive_timeout 65;" >> /etc/nginx/nginx.conf
echo "#gzip on;" >> /etc/nginx/nginx.conf
echo "#include /etc/nginx/conf.d/*.conf;" >> /etc/nginx/nginx.conf
echo "}" >> /etc/nginx/nginx.conf
#create server block config for new site
touch /etc/nginx/sites-available/azod.pw
#populate server block with proper stuff
echo "server{
  listen 80 http2;
  listen [::]:80 http2;
  root /usr/share/nginx/html/azod.pw;
  index index.html index.php;
  server_name www.azod.pw azod.pw;
  location / {
    try_files \$uri \$uri/ =404;
  }
}" > /etc/nginx/sites-available/azod.pw
#create index.html and directory for server site.
mkdir /usr/share/nginx/html/azod.pw
echo "<html>
<head>
<title>This is a website</title>
</head>
<body>
<p>This is a paragraph.</p>
</body>
</html>" > /usr/share/nginx/html/azod.pw/index.html
#comment out the last line in the http{} block 
#use # at the beginning of the line)
# the line is:
#    include /etc/nginx/conf.d/*.conf;
#create symlink to make site go live
ln -s /etc/nginx/sites-available/azod.pw /etc/nginx/sites-enabled/
systemctl restart nginx
