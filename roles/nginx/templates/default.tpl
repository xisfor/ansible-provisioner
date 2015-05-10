

upstream app_yourdomain {
    server 127.0.0.1:3000;
}

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


