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
    <h1 style="margin: 20px;">Deine Bibliotheken</h1>

    <?php
    $libraries_query = "SELECT pk_id_library, library_name FROM tbl_library";
    $result = $connection->query($libraries_query);

    if ($result->num_rows > 0) {
        echo "<div class='library-container'>";
        while ($library = $result->fetch_assoc()) {
            echo "<div class='library-child'>";
            echo $library['pk_id_library'] . ". ";
                        
            echo '<form method="post" action="album-page.php">';
            // versteckter input um die ID und username zu uebergeben            
            echo '<input type="hidden" name="pk_id_library" value="' . $library['pk_id_library'] . '">';
            echo '<button type="submit" name="' . $library['library_name'] . '_btn">' . $library['library_name'] . '</button>';
            echo '</form>';
            echo "</div>";
        }
        echo "</div>";
    } else {
        echo "<p>No libraries found</p>";
    }
    ?>
</body>
</html>

<style>
    .library-container {
        display: flex;
        flex-direction: column;
        margin: 20px;
    }
    .library-child {
        margin: 10px;
    }
</style>