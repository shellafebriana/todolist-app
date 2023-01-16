<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers:*");
$connection = new mysqli("localhost", "root", "", "todolist");
$username = $_POST['username'];
$password = $_POST['password'];

$queryresult = mysqli_query($connection, "SELECT * FROM user WHERE username='$username' AND password='$password'");
$result = array();

while ($fetchdata = $queryresult->fetch_assoc()) {
    $result[] = $fetchdata;
}

echo json_encode($result);
