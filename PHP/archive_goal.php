<?php
include 'db.php'; // Include your database connection script

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $goalId = $_POST['goal_id'];
    $goalTitle = $_POST['goal_title'];
    $sql = "UPDATE goal SET archived = 1 WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $goalId);

    // Debugging print to check if goal_id is received
    echo "Received goal_id: " . htmlspecialchars($goalId);

    if ($stmt->execute()) {
        $stmt->close();
        $conn->close();
        echo "<script>alert('Goal " . $goalTitle . " has been successfully archived.');";
        echo "window.location.href = '../html/ManageGoals.php';</script>";
            exit;
    } else {
        echo "Error: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>
