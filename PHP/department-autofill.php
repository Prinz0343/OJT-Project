<?php
$userId = $_SESSION['user_id']; // Assuming you store the user ID in the session

// Database connection
include('db.php');

// Query to fetch the department
$sql = "SELECT department FROM user WHERE user_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userId);
$stmt->execute();
$stmt->bind_result($department);
$stmt->fetch();
$stmt->close();

// Get current year
$current_year = date('Y');

$title = "<div class=\"goal-title\">" . htmlspecialchars($department) . " Department Goals</div>";

// Check if department is fetched correctly
if (empty($department)) {
    echo "Department not found for user ID: $userId";
    exit; // Exit or handle accordingly
}
?>
