

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

        {# ansible variable check for nginx_cors_origin #}
        {# example wildcard, `nginx_cors_origin: '*'` #}

        {% if nginx_cors_origin is defined %}
        if ($request_method = 'OPTIONS') {
            add_header 'Access-Control-Allow-Origin' '{{ nginx_cors_origin }}';

            # Om nom nom cookies
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';

            # Custom headers and headers various browsers *should* be OK with but aren't
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';

            # Tell client that this pre-flight info is valid for 20 days
            add_header 'Access-Control-Max-Age' 1728000;
            add_header 'Content-Type' 'text/plain charset=UTF-8';
            add_header 'Content-Length' 0;
            return 204;
        }
        if ($request_method = 'POST') {
            add_header 'Access-Control-Allow-Origin' '{{ nginx_cors_origin }}';
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        }
        if ($request_method = 'GET') {
            add_header 'Access-Control-Allow-Origin' '{{ nginx_cors_origin }}';
            add_header 'Access-Control-Allow-Credentials' 'true';
            add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
            add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        }
        {% endif %}

    }

}


