<?php
$x = 1;
phpinfo();
$isDev = getenv('docker_DEV');

if ($isDev == "1") {
    echo "Jesteś w trybie deweloperskim";
}

echo $isDev;

// Przykład w bootstrap.php lub config/database.php
//$db_host = getenv('DB_HOST');
//$db_user = getenv('DB_USER');

print_r(getenv());
echo getenv('XDEBUG_MODE');

?>