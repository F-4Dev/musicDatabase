<?php
// library.php - Display albums in a library
include 'db.php';
if (!isset($_GET['id'])) {
    die("Library ID not specified.");
}
$library_id = $_GET['id'];
$query = $pdo->prepare("SELECT * FROM tbl_album WHERE fk_id_library = ?");
$query->execute([$library_id]);
$albums = $query->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Albums in Library</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Albums in Library <?= htmlspecialchars($library_id) ?></h1>
    <ul>
        <?php foreach ($albums as $album): ?>
            <li>
                <a href="album.php?id=<?= urlencode($album['pk_album_id']) ?>">
                    <?= htmlspecialchars($album['album_name']) ?>
                </a>
                <!-- Form to favorite an album -->
                <form action="favorite.php" method="post" style="display:inline;">
                    <input type="hidden" name="type" value="album">
                    <input type="hidden" name="id" value="<?= htmlspecialchars($album['pk_album_id']) ?>">
                    <input type="submit" value="Favorite Album">
                </form>
            </li>
        <?php endforeach; ?>
    </ul>
    <a href="index.php">Back to Libraries</a>
</body>
</html>
