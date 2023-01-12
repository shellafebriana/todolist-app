<?php
$con = new mysqli('localhost', 'root', '', 'todolist');
$id_user    = 1;
$date       = date('Y-m-d');
$data = mysqli_query($con, "SELECT * FROM plan JOIN user_plan ON user_plan.id_plan = plan.id_plan WHERE id_user= '$id_user' AND tgl='$date'");
$data = mysqli_fetch_all($data, MYSQLI_ASSOC);

echo json_encode($data);
