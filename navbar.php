<?php
$user_query = "SELECT pk_username FROM tbl_user";
$result = $connection->query($user_query);
date_default_timezone_set('Europe/Berlin');
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Streaming</title>
</head>

<body>
    <nav class="navigation-bar">
        <h1 class="nav-children">
            Musikdatenbank
        </h1>
        <h1 class="nav-children" id="welcome">Wilkommen <?php echo $username; ?></h>
            <h1 class="nav-children"><?php echo date("H:i") ?></h1>
    </nav>
</body>

</html>

<style>
    body {
        margin: 0 !important;
        padding: 0 !important;
    }

    .navigation-bar {
        display: flex;
        background: gray;
        color: white;
        justify-content: space-between;
        position: relative;
        padding: 10px;
    }

    .nav-children {
        margin: 0;
        padding: 20px 30px;
    }

    .user-select-btn {
        background: gray;
        border: 1px white solid;
        color: white;
        border: none;
        cursor: pointer;
        padding: 10px 20px;
    }

    .user-select-content {
        display: none;
        position: absolute;
        right: 0;
        top: 45px;
        background: gray;
        width: 200px;
        padding: 10px;
    }

    .user-select-btn:hover+.user-select-content,
    .user-select-content:hover {
        display: block;
    }

    .user-select-children {
        background: none;
        border: none;
        color: white;
        text-decoration: underline;
        cursor: pointer;
        display: block;
        padding: 5px;
    }

    .user-select-children:hover {
        text-decoration: none;
    }
</style>