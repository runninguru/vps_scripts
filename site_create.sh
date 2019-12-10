#!/bin/bash                                                  
if [ "$1" = "-n" ] #adding a new site 
	# $2 should be the new domain name                                              
	then 
	#create server block config for new site
	touch /etc/nginx/sites-available/$2
	#populate server block with proper stuff
	echo "server{" > /etc/nginx/sites-available/$2
	echo "  listen 80;" >> /etc/nginx/sites-available/$2
	echo "  listen [::]:80;" >> /etc/nginx/sites-available/$2
	echo "  root /usr/share/nginx/html/$2;" >> /etc/nginx/sites-available/$2
	echo "  index index.html;" >> /etc/nginx/sites-available/$2
	echo "  server_name www.$2 $2;" >> /etc/nginx/sites-available/$2
	echo "  location / {" >> /etc/nginx/sites-available/$2
	echo "    try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/$2
	echo "  }" >> /etc/nginx/sites-available/$2
	echo "}" >> /etc/nginx/sites-available/$2
	#create index.html and directory for server site.
	mkdir /usr/share/nginx/html/$2
	echo "<html>" > /usr/share/nginx/html/$2/index.html
	echo "<head>" >> /usr/share/nginx/html/$2/index.html
	echo "<title>This is a website</title>" >> /usr/share/nginx/html/$2/index.html
	echo "</head>" >> /usr/share/nginx/html/$2/index.html
	echo "<body>" >> /usr/share/nginx/html/$2/index.html
	echo "<p>This is a paragraph.</p>" >> /usr/share/nginx/html/$2/index.html
	echo "</body>" >> /usr/share/nginx/html/$2/index.html
	echo "</html>" >> /usr/share/nginx/html/$2/index.html
	#comment out the last line in the http{} block 
	#use # at the beginning of the line)
	# the line is:
	#    include /etc/nginx/conf.d/*.conf;
	#create symlink to make site go live
	ln -s /etc/nginx/sites-available/$2 /etc/nginx/sites-enabled/
	echo "in build a new site option"  
fi                                                                                
if [ "$1" = "-d" ] # deactivate site but keep it around    
	# $2 should be the domain name                         
	then                        
	echo "deactivate a site but keep it around"
	rm /etc/nginx/sites-enabled/$2
	echo "------- site deactivated -------"
fi                                                                              
if [ "$1" = "-r" ] # reactivate a site (create a symlink)                                            
	then 
	ln -s /etc/nginx/sites-available/$2 /etc/nginx/sites-enabled/
        echo "reactivate a site"
fi
if [ "$1" = "-l" ] #list sites, both active and inactive.
	then
	echo "=================================="
	echo "List Available and Enabled sites"
	echo "=================================="
	echo "------------ Available -----------"
	#list files in sites-available directory
	ls /etc/nginx/sites-available/
	echo "------------- Enabled ------------"
	#list files in sites-enabled directory
	ls /etc/nginx/sites-enabled/
fi
