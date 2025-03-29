<?php

include 'navbar.php';

$servername = "localhost";
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