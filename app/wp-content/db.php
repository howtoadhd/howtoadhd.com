<?php

require_once DROPINS_DIR . '/ludicrousdb/ludicrousdb.php';

if (WP_DEBUG) {
	require_once WPMU_PLUGIN_DIR . '/query-monitor-patch/db.php';
}