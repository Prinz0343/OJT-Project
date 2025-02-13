<!--Date: June 29, 2024 - 9:41pm start
    Description: Front-end of the Manage Goals Page for the Project
    Edited: July 2 & 3 2024
            July 4 2024 by Back End Team (BET) - Create Goals Window and Manage Goals Table Functionalities
            July 5 2024 by BET - Archive Feature
            July 8 2024 by BET - Display in the CURRENT GOALS table only the records under the user's department and the current year
                               - Made the PREVIOUS GOALS table work
                               - Automatic Title for the Goals Table based on the user's department
            July 9 2024 by BET - Confirm Archive Dialog
                               - Search Feature
                               - View Feature
            July 10 2024 by BET- EDIT feature
                               - COPY feature 
    Comments of the Developer:  Read comments. Functionalities will fail to work indeed until they are connected to a backend API that handles them-->

    <?php 
    include('../php/db.php');
    include('../php/anti-shortcut_ssd.php');
    include('../php/department-autofill.php');
    include('../php/total_budget-autofill.php');
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Goals</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Lato:wght@400&display=swap');

        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            margin: 0;
            padding: 0;
        }

        .header {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding: 30px 28px;
            background-color: transparent;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            gap: 10px;
        }

        .header button {
            margin-left: 18px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            background: linear-gradient(135deg, #5A4ABD, #78909C);
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }

        .header button:hover {
            background: #D9E4F5;
            color: #4a3bb3
        }

        .logout {
            margin-left: 40px;
            margin-right: 62.5px;
            color: inherit;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }

        .logout:hover {
            color: #4a3bb3;
        }

        .goal-title {
            font-family: 'Lato', sans-serif;
            color: black;
            font-size: 18px;
            font-weight: 300;
            margin: 20px 28px;
        }

        table {
            width: calc(100% - 56px);
            border-collapse: collapse;
            margin: 20px 28px;
            font-family: 'Lato', sans-serif;
            border: 1px solid #ddd;
            border-collapse: collapse;
        }

        tr {
            width: 30px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f4f4f4;
        }

        .medium-style {
            background-color: #ddebf7;
        }

        .medium-style2 {
            background-color: #D1D1D1;
        }

        .input-bar {
            width: 30%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: white;
        }

        .search-button, .create-button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            background-color: #595B9B;
            color: white;
            cursor: pointer;
            font-size: 14px;
            font-weight: 300;
        }

        .create-button {
            margin-left: 160px;
        }

        .edit-button, .archive-button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #5A4ABD;
            color: white;
            cursor: pointer;
            font-size: 12px;
            margin-right: 3px;
        }

        .view-button, .copy-button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #5A4ABD;
            color: white;
            cursor: pointer;
            font-size: 12px;
            margin-right: 3px;
            display: inline-block;
        }

        .row-1 td:first-child {
            background-color: #FEFEFE;
        }

        .row-2 td:first-child {
            background-color: #e6ebfc;
        }
        /* Modal styles */
        /* Modal styles */
.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
    padding-top: 60px;
}

.modal-content {
    background-color: #fefefe;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 500px;
    border-radius: 10px;
    text-align: center; /* Center the text */
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

        .form-input {
            width: calc(48% - 10px);
            padding: 10px;
            margin: 5px 0;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: white;
        }

        .form-select {
            width: calc(48% - 10px);
            padding: 10px;
            margin: 5px 0;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: white;
        }

        .form-full {
            width: 100%;
        }

        .kpi-text {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f4f4f4;
            color: #333;
        }

        .save-button-container {
            width: 100%;
            text-align: right;
        }
    </style>
</head>
<body>
    <header>
        <div class="header">
            <button onclick="location.href='ManageGoals.php'">Manage Goals</button>
            <button onclick="location.href='ManageActionPlans.html'">Manage AP</button>
            <button onclick="location.href='ViewReports.html'">View Reports</button>
            <form method="post" class="logout">
                    <button type="submit" name="logout" class="logout">Log Out</button>
            </form>
        <!--
            <div class="logout">
                <a href="#" class="logout">Logout</a>
            </div>
        -->
        </div>
    </header>

    <!-- Dynamic Goal Title based on the User's Department -->
    <!-- Back End Logic is written in ../php/department-autofill.php -->
        <?php echo $title; ?>


    <table>
        <tr>
            <td colspan="5" class="medium-style">
            <!--
                <input type="text" class="input-bar" placeholder="Search...">
                <button class="search-button">Search</button>
            -->
    <form method="GET" action="ManageGoals.php" style="display: flex; align-items: center;">
    <div style="position: relative; display: inline-block;">
        <input type="text" name="search" id="searchInput" class="input-bar" placeholder="Search..." value="<?php echo isset($_GET['search']) ? htmlspecialchars($_GET['search']) : ''; ?>" style="padding-right: 24px;">
        <button type="button" id="clearSearch" style="position: absolute; right: 5px; top: 50%; transform: translateY(-50%); border: none; background: none; cursor: pointer; font-size: 16px; display: <?php echo isset($_GET['search']) && $_GET['search'] != '' ? 'inline' : 'none'; ?>;">&#10005;</button>
    </div>
        <button type="submit" class="search-button">Search</button>
    </form>


                <button class="create-button" id="createGoalBtn">Create New Goal</button>
            </td>
        </tr>
        <tr>
            <td colspan="5" class="medium-style"></td>
        </tr>
        <tr>
            <th class="medium-style">Current Goals</th>
            <th class="medium-style">Initiative</th>
            <th class="medium-style">Target</th>
            <th class="medium-style">Budget</th>
            <th class="medium-style">Actions</th>
        </tr>

        <!-- php code for displaying CURRENT GOALS and for searching goals -->
        <!-- php code for archiving is included -->
        <?php
        include '../php/current_goal.php'
        ?>

    </table>

<!-- The create Goal Modal -->
  <div id="createGoalModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>CREATE GOAL</h2>
            <form action="../php/creategoal.php" method="post">
                <input type="text" id="title" name="title" class="form-input" placeholder="Title" required>
                <input type="number" id="year" name="year" class="form-input" placeholder="Year" value="<?php echo date('Y'); ?>" readonly required>
                <input type="text" id="department" name="department" class="form-input" placeholder="Department" value="<?php echo htmlspecialchars($department); ?>" readonly required>
                <input type="text" id="targets" name="targets" class="form-input" placeholder="Targets" required>
                <input type="number" id="totalBudget" name="totalBudget" class="form-input" placeholder="Total Budget" value="0" readonly required>
                <select id="initiative" name="initiative" class="form-select" required>
                    <option value="" disabled selected>Initiative</option>
                    <!-- Options from KPI 1.1 to KPI 10.5 -->
                    <?php
                    // Define the range of values for each KPI
                    $kpi_ranges = [
                        1 => 7,
                        2 => 11,
                        3 => 3,
                        4 => 3,
                        5 => 9,
                        6 => 8,
                        7 => 3,
                        8 => 3,
                        9 => 7,
                        10 => 5
                    ];

                    // Loop through the KPIs and generate options
                    foreach ($kpi_ranges as $i => $max_j) {
                        for ($j = 1; $j <= $max_j; $j++) {
                            echo '<option value="KPI ' . $i . '.' . $j . '">KPI ' . $i . '.' . $j . '</option>';
                        }
                    }
                    ?>
                 </select>
                <div class="kpi-text" id="kpiDetails">Key performance indicator details</div>
                <div class="save-button-container">
                    <button type="submit" class="create-button">Save Goal</button>
                </div>
            </form>
        </div>
    </div>

    <script src="../php/kpiDetails.js"></script>
    <script>
        // Get the modal
        var modal = document.getElementById("createGoalModal");

        var btn = document.getElementById("createGoalBtn");

        var span = document.getElementsByClassName("close")[0];

        btn.onclick = function() {
            modal.style.display = "block";
        }

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        // Update KPI details based on initiative selection
        document.getElementById("initiative").onchange = function() {
            var selectedValue = this.value;
            updateKpiDetails(selectedValue);
        }
    </script>


    <!-- Search Bar-->
    <script>
            document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const clearSearch = document.getElementById('clearSearch');

            // Show or hide the "X" button based on input value
            function toggleClearButton() {
                if (searchInput.value.length > 0) {
                    clearSearch.style.display = 'inline';
                } else {
                    clearSearch.style.display = 'none';
                }
            }

            // Event listener to handle clearing the search
            clearSearch.addEventListener('click', function() {
                searchInput.value = '';
                toggleClearButton();
                window.location.href = 'ManageGoals.php';
            });

            // Initial check for displaying the "X" button
            toggleClearButton();

            // Update "X" button visibility when input changes
            searchInput.addEventListener('input', toggleClearButton);
        });
    </script>




<!-- Archive Confirmation Modal-->
<div id="archiveModal" class="modal" style="display:none;">
    <div class="modal-content">
        <h2>Confirm Archiving</h2>
        <p>Are you sure you want to archive this goal?</p>
        <button id="confirmYes">Yes</button>
        <button id="confirmNo">No</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(document).ready(function() {
        // Attach the confirmArchive function to buttons with the class 'archive-button'
        $('.archive-button').on('click', function(event) {
            event.preventDefault(); // Prevent default button behavior
            
            const goalId = $(this).data('goal-id');
            const goalTitle = $(this).data('goal-title');

            Swal.fire({
                title: 'Confirm Archiving',
                text: `Are you sure you want to archive this goal '${goalTitle}'?`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    // Perform the AJAX request
                    $.ajax({
                        url: '../php/archive_goal.php', // Adjust the URL to your PHP script
                        method: 'POST',
                        data: {
                            goal_id: goalId,
                            goal_title: goalTitle
                        },
                        dataType: 'json',
                        success: function(response) {
                            if (response.status === 'success') {
                                Swal.fire({
                                    title: 'Archived!',
                                    text: response.message,
                                    icon: 'success',
                                    confirmButtonText: 'OK'
                                }).then(() => {
                                    location.reload(); // Optional: Reload the page
                                });
                            } else {
                                Swal.fire({
                                    title: 'Error!',
                                    text: response.message,
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                });
                            }
                        },
                        error: function() {
                            Swal.fire({
                                title: 'Error!',
                                text: 'There was an error archiving the goal.',
                                icon: 'error',
                                confirmButtonText: 'OK'
                            });
                        }
                    });
                }
            });
        });
    });
</script>


<!-- The Edit Goal Modal -->
<div id="editGoalModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>  
        <h2>EDIT GOAL</h2>
        <form action="../php/edit_goal.php" method="post">
            <input type="hidden" id="editGoalId" name="goal_id">
            <input type="text" id="editTitle" name="title" class="form-input" placeholder="Title" required>
            <input type="number" id="editYear" name="year" class="form-input" placeholder="Year" readonly required>
            <input type="text" id="editDepartment" name="department" class="form-input" placeholder="Department" readonly required>
            <input type="text" id="editTargets" name="targets" class="form-input" placeholder="Targets" required>
            <input type="number" id="editTotalBudget" name="totalBudget" class="form-input" placeholder="Total Budget" readonly required>
            <select id="editInitiative" name="initiative" class="form-select" required>
                <option value="" disabled selected>Select Initiative</option>
                <option value="KPI 1.1">KPI 1.1</option>
                <option value="KPI 1.2">KPI 1.2</option>
                <option value="KPI 1.3">KPI 1.3</option>
                <option value="KPI 1.4">KPI 1.4</option>
            </select>
            <div class="kpi-text" id="editKpiDetails">Key performance indicator details</div>
            <div class="save-button-container">
                <button type="submit" class="create-button">Save Changes</button>
            </div>
        </form>
    </div>
</div>
    
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var editModal = document.getElementById("editGoalModal");
        var editSpan = editModal.getElementsByClassName("close")[0];

        // Close the modal when the user clicks on <span> (x)
        editSpan.onclick = function() {
            editModal.style.display = "none";
        }

        // Close the modal when the user clicks anywhere outside of it
        window.onclick = function(event) {
            if (event.target == editModal) {
                editModal.style.display = "none";
            }
        }

        document.querySelectorAll('.edit-button').forEach(function(button) {
            button.addEventListener('click', function() {
                var goalId = this.dataset.goalId; // Assuming data-goal-id attribute is set on button
                fetchEditGoalDetails(goalId);
            });
        });

        function fetchEditGoalDetails(goalId) {
            fetch(`../php/get_goal_details.php?id=${goalId}`)
                .then(response => response.json())
                .then(data => {
                    if (data.error) {
                        alert(data.error);
                    } else {
                        populateEditGoalModal(data);
                        editModal.style.display = "block";
                    }
                })
                .catch(error => console.error('Error fetching goal details:', error));
        }

        function populateEditGoalModal(goal) {
            document.getElementById("editGoalId").value = goal.id;
            document.getElementById("editTitle").value = goal.title;
            document.getElementById("editYear").value = goal.year;
            document.getElementById("editDepartment").value = goal.department;
            document.getElementById("editTargets").value = goal.targets;
            document.getElementById("editTotalBudget").value = goal.total_budget;
            document.getElementById("editInitiative").value = goal.initiative;
            document.getElementById("editKpiDetails").textContent = "Details for " + goal.initiative;
        }

        document.getElementById("editInitiative").onchange = function() {
            var selectedValue = this.value;
            var kpiDetails = document.getElementById("editKpiDetails");
            kpiDetails.textContent = "Details for " + selectedValue;
        }
    });
</script>


<!--PREVIOUS GOALS TABLE-->
<div class="previous-goals-section">
    <div class="toggle-table">
        <span id="toggleChevron" class="chevron" onclick="toggleTable()">▶</span> 
    </div>
    <table id="previousGoalsTable" style="display: none;">
        <tr>
            <th class="medium-style2">Previous Goals</th>
            <th class="medium-style2">Initiative</th>
            <th class="medium-style2">Target</th>
            <th class="medium-style2">Budget</th>
            <th class="medium-style2">Actions</th>
        </tr>

         <!-- php code for displaying PREVIOUS GOALS -->
         <!-- php codes for displaying archiving and viewing are included -->
         <?php
        include '../php/previous_goal.php'
        ?>

    </table>
</div>

    <script>
        function toggleTable() {
            var table = document.getElementById("previousGoalsTable");
            var chevron = document.getElementById("toggleChevron");

            if (table.style.display === "none") {
                table.style.display = "table";
                chevron.textContent = "▼";
            } else {
                table.style.display = "none";
                chevron.textContent = "▶";
            }
        }
    </script>

<!-- View Goal Modal -->
<div id="viewGoalModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Goal Details</h2>
        <div id="goalDetails"></div>
        <button class="ok-button" id="okButton">OK</button>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("viewGoalModal");
    var span = modal.getElementsByClassName("close")[0];
    var okButton = document.getElementById("okButton");

    span.onclick = function() {
        modal.style.display = "none";
    }

    okButton.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    document.querySelectorAll('.view-button').forEach(function(button) {
        button.addEventListener('click', function() {
            var goalId = this.dataset.goalId; // Assuming data-goal-id attribute is set on button
            fetchGoalDetails(goalId);
        });
    });

    function fetchGoalDetails(goalId) {
        fetch(`../php/view_goal.php?id=${goalId}`)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    alert(data.error);
                } else {
                    displayGoalDetails(data);
                    modal.style.display = "block";
                }
            })
            .catch(error => console.error('Error fetching goal details:', error));
    }

    function displayGoalDetails(goal) {
        var details = `
            <p><strong>Goal ID:</strong> ${goal.id}</p>
            <p><strong>Title:</strong> ${goal.title}</p>
            <p><strong>Year:</strong> ${goal.year}</p>
            <p><strong>Department:</strong> ${goal.department}</p>
            <p><strong>Targets:</strong> ${goal.targets}</p>
            <p><strong>Total Budget:</strong> ${goal.total_budget}</p>
            <p><strong>Initiative:</strong> ${goal.initiative}</p>
        `;
        document.getElementById("goalDetails").innerHTML = details;
    }
});
</script>

<script>
    // Function to simulate viewing a goal (replace with actual functionality later)
    function viewGoal(goalName) {
        alert("Viewing " + goalName);
        // Implement actual view functionality when backend is integrated
    }

    // Function to simulate editing a goal (replace with actual functionality later)
    function editGoal(goalName) {
        alert("Editing " + goalName);
        // Implement actual edit functionality when backend is integrated
    }

    // Function to simulate copying a goal (replace with actual functionality later)
    function copyGoal(goalName) {
        alert("Copying " + goalName);
        // Implement actual copy functionality when backend is integrated
    }

    // Function to simulate archiving a goal (replace with actual functionality later)
    function archiveGoal(goalName) {
        alert("Archiving " + goalName);
        // Implement actual archive functionality when backend is integrated
    }

    // Function to simulate searching for a goal (replace with actual functionality later)
    function searchGoal() {
        var searchQuery = document.getElementById("searchInput").value;
        alert("Searching for " + searchQuery);
        // Implement actual search functionality when backend is integrated
    }
</script>
</body>
</html>
