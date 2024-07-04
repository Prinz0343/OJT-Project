<?php
// Database connection details
$servername = "localhost";
$user_name = "root";
$password = "";
$dbname = "ssd";

// Create connection
$conn = new mysqli($servername, $user_name, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
else {
    echo "Connected successfully to the SSD database.";
}
?>