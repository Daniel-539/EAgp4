<?php
// config.php - 資料庫連線設定

$host = 'localhost';
$dbname = 'snack_shop';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch(PDOException $e) {
    die("資料庫連線失敗：" . $e->getMessage());
}

// 啟動 Session
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
