<?php
session_start();
$servername = "localhost";
$username = "root";
$password = "";
$dbname = 'streamingdb';

$connection = new mysqli($servername, $username, $password, $dbname);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
} else {
    include 'navbar.php';
}
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Music Libraries</title>
    <link rel="stylesheet" href="css/styles.css">
</head>

<body>
    <h1>Your Libraries</h1>
    
    <?php
    if (isset($_SESSION['username'])) {
        echo "<p>Selected User: <strong>" . $_SESSION['username'] . "</strong></p>";
    } else {
        echo "<p>No user selected</p>";
    }

    $libraries_query = "SELECT library_name FROM tbl_library";
    $result = $connection->query($libraries_query);

    if ($result->num_rows > 0) {
        echo "<ul>";
        while ($library = $result->fetch_assoc()) {        
            echo "<li><a href='album-page.php'>" . $library['library_name'] . "</a></li>";
        }
        echo "</ul>";
    } else {
        echo "<p>No libraries found</p>";
    }

    $connection->close();
    ?>
</body>

</html>
