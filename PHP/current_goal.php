    <?php

            // SQL query to fetch unarchived goals from previous years under the user's department AND search for goals


            $searchQuery = "";
            $sql = "";
            $params = [];
            $types = "";


            // Check if a search query is provided
            if (isset($_GET['search'])) {
                $searchQuery = $_GET['search'];
                $sql = "SELECT id, title, initiative, targets, total_budget FROM goal WHERE title LIKE ? OR initiative LIKE ? OR targets LIKE ?";
                $searchPattern = '%' . $searchQuery . '%';
                $params = [$searchPattern, $searchPattern, $searchPattern];
                $types = "sss"; // All three parameters are strings
            } else {
                // Code to only display the current year's unarchived records under the user's department
                $sql = "SELECT id, title, initiative, targets, total_budget FROM goal WHERE archived IS NULL AND department = ? AND year = ?";
                $params = [$department, $current_year];
                $types = "si"; // department is a string, current_year is an integer
            }



            $stmt_goals = $conn->prepare($sql);

            // Bind the department parameter
        // $stmt_goals->bind_param("si", $department, $current_year); // "si" for string and integer

        // Bind parameters if needed
            if (!empty($params)) {
                $stmt_goals->bind_param($types, ...$params);
            }
            // Execute the statement
            $stmt_goals->execute();

            // Get result set
            $result = $stmt_goals->get_result();

            if ($result->num_rows > 0) {
                $rowClass = "row-1";
                while ($row = $result->fetch_assoc()) {
                    echo "<tr class=\"$rowClass\">";
                    echo "<td>{$row['title']}</td>";
                    echo "<td>{$row['initiative']}</td>";
                    echo "<td>{$row['targets']}</td>";
                    echo "<td>{$row['total_budget']}</td>";
                    echo '<td>
                            <button class="edit-button" data-goal-id="' . $row['id'] . '">Edit</button>
                            <form method="post" action="../php/archive_goal.php" style="display:inline" onsubmit="return confirmArchive(event);">
                                <input type="hidden" name="goal_id" value="' . $row['id'] . '">
                                <input type="hidden" name="goal_title" value="' . $row['title'] . '">
                                <button type="button" class="archive-button" data-goal-id="' . $row['id'] . '" data-goal-title="' . $row['title'] . '">Archive</button>
                            </form>
                        </td>';
                    echo '</tr>';
                    // Alternate row class for styling
                    $rowClass = ($rowClass == "row-1") ? "row-2" : "row-1";
                }
            } else {
                echo "<tr><td colspan='5'>No goals found.</td></tr>";
            }
        

            ?>  