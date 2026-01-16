<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);



echo "OK";

function checkDatabaseConnection() {
    $config = [
        'host'     => getenv('DB_HOST') ?: 'localhost',
        'user'     => getenv('DB_USER'),
        'pass'     => getenv('DB_PASS'),
        'port'     => getenv('DB_PORT') ?: '3306',
        'database' => getenv('DB_NAME'),
    ];

    $dsn = "mysql:host={$config['host']};port={$config['port']};dbname={$config['database']};charset=utf8mb4";
    
    try {
        $pdo = new PDO($dsn, $config['user'], $config['pass'], [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_TIMEOUT => 5 // Czekaj max 5 sekund
        ]);

        echo "✅ Połączono pomyślnie z bazą: " . $config['database'] . " (Host: " . $config['host'] . ")\n";
        return $pdo;

    } catch (\PDOException $e) {
        echo "❌ BŁĄD POŁĄCZENIA:\n";
        echo "Komunikat: " . $e->getMessage() . "\n";
        return false;
    }
}

// Uruchomienie testu
checkDatabaseConnection();