<?php
require_once 'config.php';

$keyword = $_GET['q'] ?? '';
$category = $_GET['category'] ?? 'all';

$sql = "SELECT * FROM products WHERE 1=1";
$params = [];

if (!empty($keyword)) {
    $sql .= " AND (name LIKE ? OR name_en LIKE ? OR name_cn LIKE ?)";
    $like = "%$keyword%";
    $params[] = $like;
    $params[] = $like;
    $params[] = $like;
}

if ($category !== 'all') {
    $sql .= " AND category = ?";
    $params[] = $category;
}

$sql .= " ORDER BY id LIMIT 50";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$products = $stmt->fetchAll();

header('Content-Type: application/json');
echo json_encode($products);
?>
