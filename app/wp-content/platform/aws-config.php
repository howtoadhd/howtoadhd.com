<?php
/**
 * Configure AWS API.
 *
 * @package   HowToADHD/Platform
 *
 * Plugin Name: AWS Config
 * Description: Configure AWS API.
 */

namespace HowToADHD\Platform;

if ( defined( 'AWS_SES_WP_MAIL_ENDPOINT' ) && AWS_SES_WP_MAIL_ENDPOINT ) {

	add_filter(
		'aws_ses_wp_mail_ses_client_params', function ( $params ) {

			$params['endpoint'] = untrailingslashit( AWS_SES_WP_MAIL_ENDPOINT );

			return $params;
		}
	);
}

if ( defined( 'AWS_SES_WP_MAIL_SKIP_TLS' ) && AWS_SES_WP_MAIL_SKIP_TLS ) {

	add_filter(
		'aws_ses_wp_mail_ses_client_params', function ( $params ) {

			$params['http']['verify'] = false;

			return $params;
		}
	);
}

if ( defined( 'S3_UPLOADS_ENDPOINT' ) && S3_UPLOADS_ENDPOINT ) {

	add_filter(
		's3_uploads_s3_client_params', function ( $params ) {

			$params['endpoint']   = trailingslashit( S3_UPLOADS_ENDPOINT );
			$params['path_style'] = true;

			return $params;
		}
	);
}

if ( defined( 'S3_UPLOADS_SKIP_TLS' ) && S3_UPLOADS_SKIP_TLS ) {

	add_filter(
		's3_uploads_s3_client_params', function ( $params ) {

			$params['http']['verify'] = false;

			return $params;
		}
	);
}
