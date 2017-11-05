<?php
/**
 * Patched version of Query Monitor DB class
 *
 * @package HowToADHD\DB
 */

defined( 'ABSPATH' ) || die();

if ( defined( 'QM_DISABLED' ) && QM_DISABLED ) {
	return;
}

if ( 'cli' === php_sapi_name() && ! defined( 'QM_TESTS' ) ) {
	// For the time being, let's not load QM when using the CLI because we've no persistent storage and no means of
	// outputting collected data on the CLI. This will hopefully change in a future version of QM.
	return;
}

if ( defined( 'DOING_CRON' ) && DOING_CRON ) {
	// Let's not load QM during cron events for the same reason as above.
	return;
}

/**
 * No autoloaders for us.
 * See https://github.com/johnbillion/query-monitor/issues/7
 */
$qm_dir    = PLUGIN_DIR . '/query-monitor';
$backtrace = "{$qm_dir}/classes/Backtrace.php";
if ( ! is_readable( $backtrace ) ) {
	return;
}
require_once $backtrace;

if ( ! defined( 'SAVEQUERIES' ) ) {
	define( 'SAVEQUERIES', true );
}


/**
 * Class QM_DB
 *
 * Query Monitor collector for LudicrousDB/WPDB.
 */
class QM_DB extends LudicrousDB {

	/**
	 * Query Monitor variables.
	 *
	 * Merges so we dont stomp LudicrousDB/WPDB vars.
	 *
	 * @var array
	 */
	public $qm_php_vars = [
		'max_execution_time'  => null,
		'memory_limit'        => null,
		'upload_max_filesize' => null,
		'post_max_size'       => null,
		'display_errors'      => null,
		'log_errors'          => null,
	];

	/**
	 * Class constructor
	 */
	public function __construct() {

		foreach ( $this->qm_php_vars as $setting => &$val ) {
			$val = ini_get( $setting );
		}

		parent::__construct();

	}

	/**
	 * Perform a MySQL database query, using current database connection.
	 *
	 * @see wpdb::query()
	 *
	 * @param string $query Database query.
	 *
	 * @return int|false Number of rows affected/selected or false on error
	 */
	public function query( $query ) {

		if ( $this->show_errors ) {
			$this->hide_errors();
		}

		$result = parent::query( $query );

		if ( ! SAVEQUERIES ) {
			return $result;
		}

		$i                            = ( $this->num_queries - 1 );
		$this->queries[ $i ]['trace'] = new QM_Backtrace(
			[
				'ignore_items' => 1,
			]
		);

		if ( $this->last_error ) {
			$this->queries[ $i ]['result'] = new WP_Error( 'qmdb', $this->last_error );
		} else {
			$this->queries[ $i ]['result'] = $result;
		}

		return $result;
	}

}

$wpdb = new QM_DB();
