## SSL

In this config, SSL is required. You'll also need to configure your own cert.

As quickstart, you can generate some keys:

  openssl req -new -x509 -days 365 -sha1 -newkey rsa:1024 \
    -nodes -keyout server.key -out server.crt \
    -subj '/O=Company/OU=Department/CN=127.0.1.1'

Then in your vagrant.yml (also at project root level), something along the lines of...

  vars:
    app_root: '/vagrant'
    app_public: "{{app_root}}/public"
    apache:
      docroot: "{{app_public}}"
      servername: 10.0.0.15
    ssl:
      src_crt: server.crt
      src_key: server.key
