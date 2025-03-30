<?php
// Initialize variables for connection
$connection = null;
$errorMessage = '';

// Check if the form has been submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Sanitize user input to avoid XSS and SQL injection
    $username = htmlspecialchars($_POST['username'], ENT_QUOTES, 'UTF-8');
    $password = htmlspecialchars($_POST['password'], ENT_QUOTES, 'UTF-8');

    // Database connection parameters
    $host = 'localhost'; // Change this if your database is hosted elsewhere
    $dbname = 'streamingdb'; // Replace with your database name

    // Create a new mysqli instance
    $connection = new mysqli($host, $username, $password, $dbname);

    // Check for connection errors
    if ($connection->connect_error || $connection->error) {
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
    <title>Database Login</title>
</head>
<body>
    <h1>Login to Database</h1>
    <form action="" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" value="Connect">
    </form>

    <?php
    // Display error message if connection failed
    if ($errorMessage) {
        echo "<p style='color:red;'>$errorMessage</p>";
    }
    ?>
</body>
</html>
