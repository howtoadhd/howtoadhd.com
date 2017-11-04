<?php

namespace HowToADHD\Config;

// Disable post by email
\add_filter( 'enable_post_by_email_configuration', '__return_false' );

$settings = [
	'default_category'    => 1, // Uncategorized
	'default_post_format' => 0, // Standard
	'ping_sites'          => 'http://rpc.pingomatic.com/',
];

foreach ( $settings as $setting => $value ) {
	\add_filter(
		"pre_option_${setting}", function () use ( $value ) {
			return $value;
		}
	);
}
