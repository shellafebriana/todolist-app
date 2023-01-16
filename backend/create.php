<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers:*");
$connection = new mysqli("localhost", "root", "", "todolist");
$id_user    = 4;
$teks       = $_POST['teks'];
$date       = date('Y-m-d');
$result = mysqli_query($connection, "INSERT INTO plan VALUES ('','$teks','$date')");
if ($result) {
    $id = mysqli_insert_id($connection);
    mysqli_query($connection, "INSERT INTO user_plan VALUES ('','$id_user','$id')");
    echo json_encode([
        'message' => 'Data input successfully'
    ]);
} else {
    echo json_encode([
        'message' => 'Data Failed to input'
    ]);
}
