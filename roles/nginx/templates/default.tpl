

upstream app_server {
    server 127.0.0.1:3000;
}

server {

    listen 0.0.0.0:80;

    # redirect to remove www
    # server_name "~^www\.(.*)$" ;
    # return 301 $scheme://$1$request_uri ;

    root {{ app_public }};

    server_name "";

    try_files $uri/index.html $uri.html $uri @app;


    location @app {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;

        proxy_redirect off;
        proxy_pass http://app_server;

        # websockets
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

}


