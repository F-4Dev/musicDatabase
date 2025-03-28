<?php
// favorite.php - Handle favoriting a song or album without duplications
include 'db.php';
session_start();

// For demonstration, we're using a fixed username. Replace with session-based user in production.
$username = 'user1';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $type = $_POST['type'] ?? '';
    $id = $_POST['id'] ?? '';

    try {
        if ($type === 'song') {
            // Check if already favorited
            $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM tbl_song_userdata WHERE fk_username = ? AND fk_song_id = ?");
            $checkStmt->execute([$username, $id]);
            if ($checkStmt->fetchColumn() == 0) {
                $stmt = $pdo->prepare("INSERT INTO tbl_song_userdata (fk_username, fk_song_id) VALUES (?, ?)");
                $stmt->execute([$username, $id]);
            }
        } elseif ($type === 'album') {
            // Check if already favorited
            $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM tbl_album_favorite WHERE fk_username = ? AND fk_album_id = ?");
            $checkStmt->execute([$username, $id]);
            if ($checkStmt->fetchColumn() == 0) {
                $stmt = $pdo->prepare("INSERT INTO tbl_album_favorite (fk_username, fk_album_id) VALUES (?, ?)");
                $stmt->execute([$username, $id]);
            }
        } else {
            die("Invalid type specified.");
        }
        // Redirect back to the referring page with a success message.
        header("Location: " . ($_SERVER['HTTP_REFERER'] ?? 'index.php'));
        exit;
    } catch (PDOException $e) {
        die("Error: " . $e->getMessage());
    }
} else {
    die("Invalid request method.");
}
?>
