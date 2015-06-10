<?php
define("DB_NAME", "{{ mysql.database }}");
define("DB_USER", "{{ mysql.user }}");
define("DB_PASSWORD", "{{ mysql.password }}");
define("DB_HOST", "localhost:/tmp/mysql5.sock");
define("DB_CHARSET", "utf8");
define("DB_COLLATE", "");

$table_prefix  = "{{ wp_table_prefix }}";

{{ wp_salt.stdout }}

$serverName = "{{ wp_server_name }}";

define('WP_SITEURL', 'http://' . $serverName);
define('WP_HOME', 'http://' . $serverName);

define("WPLANG", "{{ wp_lang }}");
define("WP_DEBUG", {{ wp_debug }});
define("WP_ENV", "{{ env }}");
define("CONCATENATE_SCRIPTS", false);

if (!defined("ABSPATH")) {
  define("ABSPATH", dirname(__FILE__) . "/");
}

require_once(ABSPATH . "wp-settings.php");
