#!/usr/bin/env sh
set -e

cd /var/www/wordpress

php -r '
    error_reporting(0);
    mysqli_report( MYSQLI_REPORT_STRICT );
    $max_attempts = 300;
    $attempt      = 0;

    do {
        try {
            $db = new mysqli(
                getenv( "MYSQL_HOST" ),
                getenv( "MYSQL_USER" ),
                getenv( "MYSQL_PASSWORD" ),
                getenv( "MYSQL_DATABASE" )
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
until `wp core is-installed`; do
    echo "WordPress is not installed, retrying..."

    if [ ${ATTEMPT} == 300 ]; then
        exit 1
    fi

    sleep 5
    ATTEMPT=${ATTEMPT}+1
done
echo "WordPress is installed, starting Cavalcade..."

/usr/bin/cavalcade /var/www/wordpress
