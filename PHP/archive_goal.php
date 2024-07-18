<?php
include 'db.php'; // Include your database connection script

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $goalId = $_POST['goal_id'];
    $goalTitle = $_POST['goal_title'];
    $sql = "UPDATE goal SET archived = 1 WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $goalId);

    // Execute the statement and check for success
    if ($stmt->execute()) {
        // Send a success response back to the AJAX request
        echo json_encode(['status' => 'success', 'message' => "Goal $goalTitle has been successfully archived."]);
    } else {
        // Send an error response back to the AJAX request
        echo json_encode(['status' => 'error', 'message' => $stmt->error]);
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}
?>
