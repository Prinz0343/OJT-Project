<?php
// Include database connection details 
include('db.php');

// Get user input from the login form 
$username = $_POST['username'];
$password = $_POST['password'];

// SQL query to check if the provided credentials are valid
$sql = "SELECT * FROM user WHERE username = '$username' AND password = '$password'";
$result = $conn->query($sql);

// Check if the query returned a matching user I
if ($result === false) { 
    die("Query failed: " .$conn->error);
}

if ($result->num_rows > 0) {
    // Valid credentials, fetch user details
    $user = $result->fetch_assoc();

    // Set session variables 
    session_start(); 
    $_SESSION['logged_in'] = true;

    // Redirect to the home page 
    header("Location: ../html/LandingPage.html");
}

else {

    // Invalid credentials, display error message in a dialog box
    echo '<script>';
    echo 'alert("Wrong username or password. Please try again.");';
    
    //echo 'window.location.href = "../html/LogInPage.html";';
    echo '</script>';
    exit(); // Make sure to exit after the script to prevent further execution
    }
    
    // Close the database connection
    $conn->close();
    
    ?>