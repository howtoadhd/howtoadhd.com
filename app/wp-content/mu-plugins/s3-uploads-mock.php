<?php

namespace HowToADHD\S3_Uploads;

if ( defined( 'S3_ENDPOINT' ) && S3_ENDPOINT ) {

	add_filter( 's3_uploads_s3_client_params', function ( $params ) {

		$params['endpoint']   = trailingslashit( S3_ENDPOINT );
		$params['path_style'] = true;

		$params['http']['verify'] = false;

		return $params;
	} );
}