<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers:*");
$con = new mysqli('localhost', 'root', '', 'todolist');
$id_user    = 4;
$date       = date('Y-m-d');
$data = mysqli_query($con, "SELECT * FROM plan JOIN user_plan ON user_plan.id_plan = plan.id_plan WHERE id_user= '$id_user'");
$data = mysqli_fetch_all($data, MYSQLI_ASSOC);

echo json_encode($data);
