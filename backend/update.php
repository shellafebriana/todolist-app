<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers:*");
$connection = new mysqli("localhost", "root", "", "todolist");
$id         = $_POST['id_plan'];
$teks       = $_POST['teks'];
$date       = date('Y-m-d');
$result = mysqli_query($connection, "UPDATE plan SET teks='$teks', tgl='$date' WHERE id_plan='$id'");

if ($result) {
    echo json_encode([
        'message' => 'Data edit successfully'
    ]);
} else {
    echo json_encode([
        'message' => 'Data Failed to update'
    ]);
}
