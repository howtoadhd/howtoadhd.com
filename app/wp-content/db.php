<?php
/**
 * Include the cavalcade runner
 *
 * Load LudicrousDB and patch for Query Monitor.
 *
 * @package   HowToADHD/Platform
 *
 * Description: LudicrousDB and patch for Query Monitor.
 */

require_once PLATFORM_DIR . '/ludicrousdb/ludicrousdb.php';

if ( WP_DEBUG ) {
	require_once WPMU_PLUGIN_DIR . '/query-monitor-patch/db.php';
}
