<?php
wp_load_translations_early();

$protocol = wp_get_server_protocol();
header( "$protocol 503 Service Unavailable", true, 503 );
header( 'Content-Type: text/html; charset=utf-8' );
header( 'Retry-After: 600' );
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Maintenance</title>

</head>
<body>
<h1>Briefly unavailable for scheduled maintenance. Check back in a minute.</h1>
</body>
</html>
