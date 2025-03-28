<?php
// index.php - Homepage listing libraries
include 'db.php';
$query = $pdo->query("SELECT * FROM tbl_library");
$libraries = $query->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Music Libraries</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Music Libraries</h1>
    <ul>
        <?php foreach ($libraries as $library): ?>
            <li>
                <a href="library.php?id=<?= urlencode($library['pk_id_library']) ?>">
                    Library <?= htmlspecialchars($library['pk_id_library']) ?>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
</body>
</html>
