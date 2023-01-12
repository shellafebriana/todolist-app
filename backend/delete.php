<?php
$connection = new mysqli("localhost", "root", "", "todolist");
$id = $_POST['id_plan'];
$result = mysqli_query($connection, "delete from plan where id_plan=" . $id);
if ($result) {
    mysqli_query($connection, "delete from user_plan where id_plan=" . $id);
    echo json_encode([
        'message' => 'Data delete successfully'
    ]);
} else {
    echo json_encode([
        'message' => 'Data Failed to delete'
    ]);
}
