<?php

$host = 'azuresql-server-380301458.database.windows.net';
$dbname = 'dados';
$user = 'admin_user';
$pass = 'satc@2025';

try {
    $pdo = new PDO("sqlsrv:Server=$host;Database=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erro na conexão com o banco: " . $e->getMessage());
}
