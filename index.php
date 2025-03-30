<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Database connection parameters
    $host = 'localhost'; 
    $dbname = 'streamingdb';

    // 
    $connection = new mysqli($host, $username, $password, $dbname);

    if ($connection->connect_error) {
        echo "Connection failed";
    } else {        
        include 'library-page.php';
        $connection->close();
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/styles.css">
    <title>Database Login</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <h1>Login Musikdatenbank :)</h1>
    <form action="" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input class="connect-btn" type="submit" value="Connect">
    </form>

    <?php
    // Display error message if connection failed
    if ($errorMessage) {
        echo "<p style='color:red;'>$errorMessage</p>";
    }
    ?>
</body>
</html>

<style>
    body {
        display: flex;
        flex-direction: column;
        align-items: center !important;
        height: 100%;
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .connect-btn {
        margin: 20px 0 !important;
        width: 100%;
    }
</style>