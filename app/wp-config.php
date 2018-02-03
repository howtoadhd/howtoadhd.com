<?php
/**
 * Configure WordPress
 *
 * @package HowToADHD
 */

// sane default for wp-cli etc.
if ( ! isset( $_SERVER['HTTP_HOST'] ) ) { // WPCS: input var ok.
	$_SERVER['HTTP_HOST'] = '';
}

if ( isset( $_SERVER['HTTP_X_FORWARDED_PROTO'] ) && strpos( $_SERVER['HTTP_X_FORWARDED_PROTO'], 'https' ) !== false ) { // WPCS: input var ok, sanitization ok.
	$_SERVER['HTTPS'] = 'on';
}

/**
 * MySQL settings
 */
define( 'DB_COLLATE', 'utf8mb4_general_ci' );
define( 'DB_CHARSET', 'utf8mb4' );

$table_prefix = 'wp_';

/**
 * Authentication keys and salts
 */
define( 'AUTH_KEY', getenv( 'AUTH_KEY' ) );
define( 'SECURE_AUTH_KEY', getenv( 'SECURE_AUTH_KEY' ) );
define( 'LOGGED_IN_KEY', getenv( 'LOGGED_IN_KEY' ) );
define( 'NONCE_KEY', getenv( 'NONCE_KEY' ) );
define( 'AUTH_SALT', getenv( 'AUTH_SALT' ) );
define( 'SECURE_AUTH_SALT', getenv( 'SECURE_AUTH_SALT' ) );
define( 'LOGGED_IN_SALT', getenv( 'LOGGED_IN_SALT' ) );
define( 'NONCE_SALT', getenv( 'NONCE_SALT' ) );

/**
 * Site URL
 */
defined( 'WP_SITEURL' ) || define( 'WP_SITEURL', 'https://' . $_SERVER['HTTP_HOST'] ); // WPCS: input var ok, sanitization ok.
defined( 'WP_HOME' ) || define( 'WP_HOME', 'https://' . $_SERVER['HTTP_HOST'] ); // WPCS: input var ok, sanitization ok.

/**
 * Filesystem settings
 */
const DISALLOW_FILE_EDIT = true;
const DISALLOW_FILE_MODS = true;

/**
 * Set wp-content dir
 */
const WP_CONTENT_DIR = __DIR__ . '/wp-content';
define( 'WP_CONTENT_URL', WP_SITEURL . '/wp-content' );

/**
 * Set mu-plugins dir
 */
const WPMU_PLUGIN_DIR = WP_CONTENT_DIR . '/mu-plugins';
define( 'WPMU_PLUGIN_URL', WP_CONTENT_URL . '/mu-plugins' );

/**
 * Set plugins dir
 */
const PLUGIN_DIR = WP_CONTENT_DIR . '/plugins';
define( 'PLUGIN_URL', WP_CONTENT_URL . '/plugins' );

/**
 * Debug
 */
$env = getenv( 'WP_DEBUG' );
if ( $env ) {
	define( 'WP_DEBUG', $env );
} else {
	define( 'WP_DEBUG', false );
}
unset( $env );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/wordpress/' );
}

/**
 * Dont concat scripts
 */
const CONCATENATE_SCRIPTS = false;

/**
 * It's time to begin - now count it in 5-6-7-8
 */
require_once __DIR__ . '/vendor/autoload.php';
require_once __DIR__ . '/roles.php';

\HowToADHD\WPPlatform\PlatformFactory::create()
	->register();
require_once ABSPATH . 'wp-settings.php';
