<?php
$user_query = "SELECT pk_username FROM tbl_user";
$result = $connection->query($user_query);
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
        <ol class="nav-children">
            MusicStreaming
        </ol>
        <button class="user-select-btn">Select User</button>
        <div class="user-select-content">
            <?php
            if ($result->num_rows > 0) {
                echo "<from method='post'>";
                while ($user = $result->fetch_assoc()) {
                    echo '<input type=submit class="user-select-children" value=' . $user["pk_username"] . ' />';
                }
                echo "</from>";
            } else {
                echo "<p>No User Found</p>";
            }
            ?>
        </div>
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
    }

    .nav-children {
        margin: 0;
        padding: 20px 30px 20px 30px;
    }

    .user-select-btn {
        background: darkblue;
        color: white;
        border: none;
        cursor: pointer;
        padding: 20px 30px;
    }

    .user-select-content {
        visibility: hidden;
        position: absolute;
        right: 0;
        top: 59px;
        background: gray;
        width: inherit;
    }

    .user-select-btn:hover+.user-select-content,
    .user-select-content:hover {
        visibility: visible;
        /* Show dropdown on button hover */
    }

    .user-select-children {
        color: white;
        text-decoration: underline;
        padding: 20px;
        z-index: 999;
    }
</style>