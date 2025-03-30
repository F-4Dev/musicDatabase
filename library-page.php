<?php
include 'navbar.php';
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
    ?>
</body>

</html>
