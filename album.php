<?php
// album.php - Display songs in an album and show if they are already favorited
include 'db.php';
session_start();

// For demonstration, we're using a fixed username.
// In production, retrieve the logged in user from session.
$username = 'user1';

if (!isset($_GET['id'])) {
    die("Album ID not specified.");
}
$album_id = $_GET['id'];

// Fetch songs for this album.
$query = $pdo->prepare("SELECT * FROM tbl_song WHERE fk_album_id = ?");
$query->execute([$album_id]);
$songs = $query->fetchAll(PDO::FETCH_ASSOC);

// Fetch all song IDs that the user has favorited.
$favStmt = $pdo->prepare("SELECT fk_song_id FROM tbl_song_userdata WHERE fk_username = ?");
$favStmt->execute([$username]);
$favorites = $favStmt->fetchAll(PDO::FETCH_COLUMN);
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Album Songs</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Songs in Album <?= htmlspecialchars($album_id) ?></h1>
    <ul>
        <?php foreach ($songs as $song): ?>
            <li>
                <?= htmlspecialchars($song['song_name']) ?>
                <?php if (in_array($song['pk_song_id'], $favorites)): ?>
                    <span style="color:green;">(Favorited)</span>
                <?php else: ?>
                    <!-- Form to favorite a song -->
                    <form action="favorite.php" method="post" style="display:inline;">
                        <input type="hidden" name="type" value="song">
                        <input type="hidden" name="id" value="<?= htmlspecialchars($song['pk_song_id']) ?>">
                        <input type="submit" value="Favorite Song">
                    </form>
                <?php endif; ?>
            </li>
        <?php endforeach; ?>
    </ul>
    <a href="library.php?id=<?= urlencode($_GET['library_id'] ?? '') ?>">Back</a>
</body>
</html>
