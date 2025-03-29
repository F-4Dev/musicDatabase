<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = 'streamingdb';

// Create connection
$connection = new mysqli($servername, $username, $password, $dbname);

// Check connection
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
    // Eine Abfrage um alle Biblioteken anzuzeigen
    $libraries_query = "SELECT library_name FROM tbl_library";
    $result = $connection->query($libraries_query);

    if ($result->num_rows > 0) {
        echo "<ul>";
        while ($library = $result->fetch_assoc()) {        
            echo "<li>";
            echo "<a href='album-page.php'>" . $library['library_name'] . "</a>";            
            echo "</li>";
        }
    } else {
        $libraries = []; // No results found
    }
    echo "</ul>";

    mysqli_close($connection);
    ?>
</body>

</html>

<?php
$connection->close(); // Close the database connection
?>