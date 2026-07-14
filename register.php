<?php
require_once 'config.php';

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';

    // 驗證
    if (empty($username) || empty($email) || empty($password)) {
        $error = '請填寫所有欄位';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error = '請輸入有效嘅電郵地址';
    } elseif (strlen($password) < 6) {
        $error = '密碼至少 6 個字元';
    } elseif ($password !== $confirm_password) {
        $error = '密碼唔匹配';
    } else {
        try {
            // 檢查用戶名或電郵是否已存在
            $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
            $stmt->execute([$username, $email]);
            if ($stmt->rowCount() > 0) {
                $error = '用戶名或電郵已經被註冊';
            } else {
                // 加密密碼
                $hashed_password = password_hash($password, PASSWORD_DEFAULT);
                $stmt = $pdo->prepare("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
                $stmt->execute([$username, $email, $hashed_password]);
                $success = '註冊成功！請 <a href="login.php">登入</a>';
            }
        } catch (PDOException $e) {
            $error = '註冊失敗：' . $e->getMessage();
        }
    }
}
?>
<!DOCTYPE html>
<html lang="zh-HK">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員註冊 - 零食站</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .auth-page { max-width: 420px; margin: 60px auto; padding: 30px; background: #fff; border-radius: 24px; box-shadow: 0 4px 24px rgba(0,0,0,0.06); }
        .auth-page h2 { text-align: center; margin-bottom: 24px; color: #d97747; }
        .auth-page label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 14px; }
        .auth-page input { width: 100%; padding: 12px 16px; border: 2px solid #e8e0d8; border-radius: 12px; font-size: 16px; margin-bottom: 16px; transition: 0.2s; }
        .auth-page input:focus { border-color: #d97747; outline: none; }
        .auth-page .btn-submit { width: 100%; padding: 14px; background: #d97747; color: #fff; border: none; border-radius: 12px; font-size: 18px; font-weight: 600; cursor: pointer; }
        .auth-page .btn-submit:hover { background: #b85e2e; }
        .auth-page .error { color: #d44c4c; padding: 10px; background: #fde8e8; border-radius: 8px; margin-bottom: 16px; }
        .auth-page .success { color: #2d8a4e; padding: 10px; background: #e8f5ee; border-radius: 8px; margin-bottom: 16px; }
        .auth-page .link { text-align: center; margin-top: 16px; color: #888; }
        .auth-page .link a { color: #d97747; text-decoration: none; font-weight: 600; }
        .auth-page .link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="auth-page">
        <h2>🍭 會員註冊</h2>
        <?php if ($error): ?><div class="error"><?= htmlspecialchars($error) ?></div><?php endif; ?>
        <?php if ($success): ?><div class="success"><?= $success ?></div><?php endif; ?>
        <form method="POST">
            <label>用戶名</label>
            <input type="text" name="username" required value="<?= htmlspecialchars($_POST['username'] ?? '') ?>">
            <label>電郵</label>
            <input type="email" name="email" required value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
            <label>密碼 (最少 6 個字元)</label>
            <input type="password" name="password" required>
            <label>確認密碼</label>
            <input type="password" name="confirm_password" required>
            <button type="submit" class="btn-submit">註冊</button>
        </form>
        <div class="link">已經有帳戶？<a href="login.php"> 登入</a></div>
    </div>
</body>
</html>
