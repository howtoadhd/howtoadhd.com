<?php

namespace HowToADHD\AWS_SES_WP_Mail;

if ( defined( 'AWS_SES_WP_MAIL_ENDPOINT' ) && AWS_SES_WP_MAIL_ENDPOINT ) {

	add_filter( 'aws_ses_wp_mail_ses_client_params', function ( $params ) {

		$params['endpoint'] = untrailingslashit( AWS_SES_WP_MAIL_ENDPOINT );

		return $params;
	} );
}
