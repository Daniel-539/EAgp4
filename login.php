<?php
require_once 'config.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';

    if (empty($username) || empty($password)) {
        $error = '請輸入用戶名同密碼';
    } else {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = ? OR email = ?");
        $stmt->execute([$username, $username]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            header('Location: index.php');
            exit;
        } else {
            $error = '用戶名或密碼錯誤';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="zh-HK">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員登入 - 零食站</title>
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
        .auth-page .link { text-align: center; margin-top: 16px; color: #888; }
        .auth-page .link a { color: #d97747; text-decoration: none; font-weight: 600; }
        .auth-page .link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="auth-page">
        <h2>🍭 會員登入</h2>
        <?php if ($error): ?><div class="error"><?= htmlspecialchars($error) ?></div><?php endif; ?>
        <form method="POST">
            <label>用戶名 或 電郵</label>
            <input type="text" name="username" required>
            <label>密碼</label>
            <input type="password" name="password" required>
            <button type="submit" class="btn-submit">登入</button>
        </form>
        <div class="link">未有帳戶？<a href="register.php"> 立即註冊</a></div>
    </div>
</body>
</html>
