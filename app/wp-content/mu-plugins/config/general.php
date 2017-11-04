<?php

namespace HowToADHD\Config;

$settings = [
	'blogname'           => 'How To ADHD',
	'blogdescription'    => 'A toolbox with tips, tricks and insights into the ADHD brain!',
	'admin_email'        => \getenv( 'ADMIN_EMAIL' ),
	'users_can_register' => 0,  // No
	'default_role'       => 'subscriber',
	'WPLANG'             => 'en_US',
	'timezone_string'    => 'America/Los_Angeles',
	'date_format'        => 'F j, Y', // October 20, 2017
	'time_format'        => 'g:i a', // 6:31 pm
	'start_of_week'      => 1, // Monday
];

foreach ( $settings as $setting => $value ) {
	\add_filter(
		"pre_option_${setting}", function () use ( $value ) {
			return $value;
		}
	);
}
