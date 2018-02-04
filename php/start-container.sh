#!/usr/bin/env sh
set -e

cd /app/www/wordpress

php -r '
    require "/app/www/vendor/autoload.php";

	use HowToADHD\WPPlatform\Service\Database;

	$db_master = Database::get_db_server();

	if( empty( $db_master ) ) {
		echo "DB_MASTER environment variable is not set!" . PHP_EOL;
		exit( 1 );
	}

	print_r( $db_master );

	error_reporting(0);
	mysqli_report( MYSQLI_REPORT_STRICT );
	$max_attempts = 300;
	$attempt      = 0;

	do {
		try {
			$db = new mysqli(
				$db_master["host"],
				$db_master["user"],
				$db_master["password"],
				$db_master["name"]
			);
			$db->close();

		} catch ( Exception $e ) {
			echo "Could not connect to database, retrying..." . PHP_EOL;
			$attempt ++;
			sleep( 5 );
			continue;
		}

		echo "Successfully connected to database, continuing..." . PHP_EOL;
		exit( 0 );

	} while ( $attempt < $max_attempts );

	echo "Could not connect after $max_attempts attempts!" . PHP_EOL;
	exit( 1 );'

ATTEMPT=0
until `wp core is-installed --allow-root`; do
    echo "WordPress is not installed, retrying..."

    if [ ${ATTEMPT} == 300 ]; then
        exit 1
    fi

    sleep 5
    ATTEMPT=${ATTEMPT}+1
done
echo "WordPress is installed, starting PHP-FPM..."

php-fpm7
