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
            echo "<p>Keine alben gefunden</p>";
        }
        echo "Ausgewaehlte Library ID: " . $current_library_id;
    } else {
        echo "Keine ID gefunden";
    }

    /* 
    Funktioniert nicht weiter. Die Verbindung zu Datenbank mit dem Ausgewaeltem Benutzer
    ist nicht mehr vorhanden.
    */

    ?>

</body>

</html>