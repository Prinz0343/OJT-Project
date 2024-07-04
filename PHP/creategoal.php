<?php
include 'connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $title = $_POST['title'];
    $year = $_POST['year'];
    $department = $_POST['department'];
    $targets = $_POST['targets'];
    $total_budget = $_POST['totalBudget'];
    $initiative = $_POST['initiative'];
    $user_id = 1; // Assuming user_id is static or retrieved from session

    $sql = "INSERT INTO goal (title, year, department, targets, total_budget, initiative, user_id)
            VALUES ('$title', '$year', '$department', '$targets', '$total_budget', '$initiative', '$user_id')";

    if ($conn->query($sql) === TRUE) {
        echo "New goal created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    $conn->close();
}
?>
