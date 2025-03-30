<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Alben</title>
    <link rel="stylesheet" href="css/styles.css">
</head>

<body>
    <h1 style="margin: 20px;">Deine Alben</h1>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        if (isset($_POST['pk_id_library'])) {
            $current_library_id = $_POST['pk_id_library'];
        } else {
            echo "<p>No libraries found</p>";
        }
        echo "Selected Library ID: " . $current_library_id;
    } else {
        echo "No library ID was submitted.";
    }

    $album_query = "SELECT pk_album_id, album_name FROM tbl_album WHERE fk_id_library = '" . $current_library_id . "';";
    echo $album_query;
    $album_result = $connection->query($album_query);
    echo "hey";



    ?>

</body>

</html>