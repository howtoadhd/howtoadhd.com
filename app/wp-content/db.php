<?php
/**
 * Include LudicrousDB and the Query Monitor patch
 *
 * @package   HowToADHD/DB
 *
 * Description: LudicrousDB and patch for Query Monitor
 */

// Include LudicrousDB.
require_once PLATFORM_DIR . '/ludicrousdb/ludicrousdb.php';

// Include Query Monitor Patch in debug mode.
if ( WP_DEBUG ) {
	require_once WPMU_PLUGIN_DIR . '/query-monitor-patch/db.php';
}
