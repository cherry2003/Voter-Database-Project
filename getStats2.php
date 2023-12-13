


<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['custom1_submit'])) {
    require_once("conn.php");
    $custom1_query = "SELECT * FROM party_demographic_stats;";
    try
    {
      $prepared_stmt_custom1 = $dbo->prepare($custom1_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_custom1->execute();
      $custom1_result = $prepared_stmt_custom1->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>



<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['custom2_submit'])) {
    require_once("conn.php");
    $custom2_query = "SELECT * FROM get_yearly_stats;";
    try
    {
      $prepared_stmt_custom2 = $dbo->prepare($custom2_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_custom2->execute();
      $custom2_result = $prepared_stmt_custom2->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>




<html>
  <head>
    <link rel="stylesheet" type="text/css" href="project.css" />
  </head> 
  <body>
    <div id="navbar">
      <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="getVoter.php">Search Voter</a></li>
        <li><a href="insertVote.php">Insert Record</a></li>
        <li><a href="deleteVote.php">Delete Voter</a></li>
        <li><a href="getStats.php">Analytics 1</a></li>
        <li><a href="getStats2.php">Analytics 2</a></li>
        <li><a href="audit.php">Audit</a></li>
      </ul>
    </div>
    <h1> Analytics 2 </h1>
    <form method="post">
      
      <input type="submit" name="custom1_submit" value="Get Age Gender by Party Stats">
      <input type="submit" name="custom2_submit" value="Get Yearly Stats">
    </form>

    <!-- get constituents' party stats -->
    

    <!-- get dem regional stats -->
    

     <!-- get age gender by party stats-->
    <?php
          if (isset($_POST['custom1_submit'])) {

            if ($custom1_result && $prepared_stmt_custom1->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Average Age and Gender Distribution Across Parties</h2>
              <table>
                <thead>
                  <tr>
                    <th>Party</th>
                    <th>Females</th>
                    <th>Males</th>
                    <th>Unisex</th>
                    <th>Average Age</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($custom1_result as $custom1_row) { ?>
                
                    <tr>
                      <td><?php echo $custom1_row["party_cd"]; ?></td>
                      <td><?php echo $custom1_row["female_count"]; ?></td>
                      <td><?php echo $custom1_row["male_count"]; ?></td>
                      <td><?php echo $custom1_row["unisex_count"]; ?></td>
                      <td><?php echo $custom1_row["AVG(age)"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found in the database. </h3>
            <?php }
        } ?>

        <!-- get age gender by party stats -->
    

     <!-- get yearly stats-->
    <?php
          if (isset($_POST['custom2_submit'])) {

            if ($custom2_result && $prepared_stmt_custom2->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Voter Data by Year</h2>
              <table>
                <thead>
                  <tr>
                    <th>Registration Year</th>
                    <th>Average Voter Age</th>
                    <th>Total Voters</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($custom2_result as $custom2_row) { ?>
                
                    <tr>
                      <td><?php echo $custom2_row["year"]; ?></td>
                      <td><?php echo $custom2_row["AVG(age)"]; ?></td>
                      <td><?php echo $custom2_row["COUNT(*)"]; ?></td>
                    </tr>
                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>

            <?php } else { ?>
              <!-- IF query execution resulted in error display the following message-->
              <h3>Sorry, no results found in the database. </h3>
            <?php }
        } ?>
 <!-- get yearly stats -->
      
    
  </body>
</html>


