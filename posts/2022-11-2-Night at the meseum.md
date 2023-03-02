---
categories:
- nginx
- linux
description: Just a collection of my thoughts.
layout: post
tags:
- AWS
- nginx
- Linux
title: Night at the Meseum!
toc: true
execute:
  freeze: auto

---

A couple people wanted websockets to work, so here is the nginx I used to get websockets working for personal project which I hosted on school servers. 

```nginx
 server {
        listen 80 default_server;
        listen [::]:80 default_server;
        server_name your.domain.com; # replace with your actual domain

        location / { 
                # Upgrade WebSockets
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'Upgrade';
                # Increase header buffer
                proxy_connect_timeout 10; 
                proxy_send_timeout 90; 
                proxy_read_timeout 90; 
                proxy_buffer_size 128k;
                proxy_buffers 4 256k;
                proxy_busy_buffers_size 256k;
                proxy_temp_file_write_size 256k;
                proxy_pass http://127.0.0.1:8080; # change port
            }
        }
```

This is what I used. It's similar to the config provided by Mr. Mortenssen, except with stuff added to make websockets work. It works with certbot as well, so I had websockets and ssl on my website. 



Other than that, I saw a lot of cool projects. 
