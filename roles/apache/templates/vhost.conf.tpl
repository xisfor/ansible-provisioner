# Default Apache virtualhost template

<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot {{ apache.docroot }}
    ServerName {{ apache.servername }}

    <Directory {{ apache.docroot }}>
        AllowOverride All
        Options -Indexes +FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>

<VirtualHost *:443>

    DocumentRoot {{ apache.docroot }}

    SSLEngine on
    SSLOptions +StrictRequire

    <Directory {{ apache.docroot }}>
        SSLRequireSSL

        AllowOverride All
        Options -Indexes +FollowSymLinks
        Require all granted
    </Directory>

    SSLCipherSuite RC4-SHA:AES128-SHA:HIGH:!aNULL:!MD5
    SSLHonorCipherOrder on

    SSLCertificateFile /etc/apache2/ssl/server.crt
    SSLCertificateKeyFile /etc/apache2/ssl/server.key

    SSLVerifyClient none
    SSLProxyEngine off

    <IfModule mime.c>
        AddType application/x-x509-ca-cert      .crt
        AddType application/x-pkcs7-crl         .crl
    </IfModule>

    SetEnvIf User-Agent ".*MSIE.*" \
      nokeepalive ssl-unclean-shutdown \
      downgrade-1.0 force-response-1.0
</VirtualHost>
