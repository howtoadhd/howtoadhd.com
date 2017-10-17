<?php

require_once WPMU_PLUGIN_DIR . '/ludicrousdb/ludicrousdb/drop-ins/db.php';

if (WP_DEBUG) {
	require_once WPMU_PLUGIN_DIR . '/query-monitor-patch/db.php';
}