<?php

namespace HowToADHD\Config;

// Disable post by email
\add_filter( 'enable_post_by_email_configuration', '__return_false' );
