<?php

require "/var/www/vendor/autoload.php";

use HowToADHD\WPPlatform\Service\Database;

$db_master = Database::get_db_server();

define( 'DB_HOST', $db_master["host"] );
define( 'DB_NAME', $db_master["name"] );
define( 'DB_USER', $db_master["user"] );
define( 'DB_PASSWORD', $db_master["password"] );

unset( $db_master );
