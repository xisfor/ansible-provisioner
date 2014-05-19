#user ubuntu;

# http {

    # worker_processes 4;
    # pid /var/run/nginx.pid;

    # events {
    #     worker_connections  1024;
    # }

    upstream app_yourdomain {
        server 127.0.0.1:3000;
    }


    # ##
    # # Basic Settings
    # ##

    # sendfile on;
    # tcp_nopush on;
    # tcp_nodelay on;
    # keepalive_timeout 300;
    # types_hash_max_size 2048;
    # # server_tokens off;

    # # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    # ##
    # # Logging Settings
    # ##

    # access_log /var/log/nginx/access.log;
    # error_log /var/log/nginx/error.log;

    # ##
    # # Gzip Settings
    # ##

    # gzip on;
    # gzip_disable "msie6";

    # gzip_vary on;
    # gzip_proxied any;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    # gzip_http_version 1.1;
    # gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # nginx-naxsi config
    ##
    # Uncomment it if you installed nginx-naxsi
    ##

    # include /etc/nginx/naxsi_core.rules;

    server {

        listen 0.0.0.0:80;

        # redirect to remove www
        # server_name "~^www\.(.*)$" ;
        # return 301 $scheme://$1$request_uri ;

        server_name "";

        location / {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_set_header X-NginX-Proxy true;

            proxy_pass http://app_yourdomain/;
            proxy_redirect off;

            # websockets
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
        }

        # root {{ app_public }};
    }
# }

