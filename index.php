<?php
$servername = "localhost";
$username = "user1";
$password = "password";
$dbname = "streamingdb";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch all users
$userQuery = "SELECT pk_username FROM tbl_user";
$userResult = $conn->query($userQuery);

// Fetch all albums
$albumQuery = "SELECT pk_album_id, album_name FROM tbl_album";
$albumResult = $conn->query($albumQuery);

// Get selected user
$selectedUser = isset($_GET['user']) ? $_GET['user'] : ''; 

// Query to fetch favorite albums of selected user
$favAlbums = [];
if ($selectedUser) {
    $favQuery = "SELECT a.pk_album_id, a.album_name FROM tbl_album_favorite af JOIN tbl_album a ON af.fk_album_id = a.pk_album_id WHERE af.fk_username = ?";
    $stmt = $conn->prepare($favQuery);
    $stmt->bind_param("s", $selectedUser);
    $stmt->execute();
    $favResult = $stmt->get_result();
    while ($row = $favResult->fetch_assoc()) {
        $favAlbums[] = $row;
    }
    $stmt->close();
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Albums</title>
</head>
<body>
    <h2>Select a User</h2>
    <form method="GET">
        <select name="user" onchange="this.form.submit()">
            <option value="">Select a user</option>
            <?php while ($user = $userResult->fetch_assoc()): ?>
                <option value="<?php echo $user['pk_username']; ?>" <?php echo ($selectedUser == $user['pk_username']) ? 'selected' : ''; ?>>
                    <?php echo $user['pk_username']; ?>
                </option>
            <?php endwhile; ?>
        </select>
    </form>

    <h2>All Albums</h2>
    <ul>
        <?php while ($album = $albumResult->fetch_assoc()): ?>
            <li>Album ID: <?php echo $album["pk_album_id"]; ?> - Name: <?php echo $album["album_name"]; ?></li>
        <?php endwhile; ?>
    </ul>

    <?php if ($selectedUser): ?>
        <h2>Favorite Albums of <?php echo $selectedUser; ?></h2>
        <?php if (!empty($favAlbums)): ?>
            <ul>
                <?php foreach ($favAlbums as $fav): ?>
                    <li>Album ID: <?php echo $fav["pk_album_id"]; ?> - Name: <?php echo $fav["album_name"]; ?></li>
                <?php endforeach; ?>
            </ul>
        <?php else: ?>
            <p>No favorite albums found for <?php echo $selectedUser; ?>.</p>
        <?php endif; ?>
    <?php endif; ?>

</body>
</html>
<?php $conn->close(); ?>
