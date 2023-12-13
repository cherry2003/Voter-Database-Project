


<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['audit_insert'])) {
    require_once("conn.php");
    $audit_insert = "SELECT * FROM audit_insert;";
    try
    {
      $prepared_stmt_audit_insert = $dbo->prepare($audit_insert);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_audit_insert->execute();
      $audit_insert_result = $prepared_stmt_audit_insert->fetchAll();
    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>



<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['audit_delete_submit'])) {
    require_once("conn.php");
    $audit_delete_query = "SELECT * FROM audit_delete;";
    try
    {
      $prepared_stmt_audit_delete = $dbo->prepare($audit_delete_query);
      //Execute the query and save the result in variable named $result
      $prepared_stmt_audit_delete->execute();
      $audit_delete_result = $prepared_stmt_audit_delete->fetchAll();
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
    <h1> Audit </h1>
    <form method="post">
      
      <input type="submit" name="audit_insert" value="Audit Insert Table">
      <input type="submit" name="audit_delete_submit" value="Audit Update Table">
    </form>

    <!-- get constituents' party stats -->
    

    <!-- get dem regional stats -->
    

     <!-- get rep regional stats-->
    <?php
          if (isset($_POST['audit_insert'])) {

            if ($audit_insert_result && $prepared_stmt_audit_insert->rowCount() > 0) { ?>
                 <!-- first show the header of RESULT -->
              <h2>Audit Insert Table</h2>
              <table>
                <thead>
                  <tr>
                    <th>Voter Reg Num</th>
                    <th>Party Code</th>
                    <th>Inserted on</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($audit_insert_result as $audit_insert_row) { ?>
                
                    <tr>
                      <td><?php echo $audit_insert_row["voter_reg_num"]; ?></td>
                      <td><?php echo $audit_insert_row["party_cd"]; ?></td>
                      <td><?php echo $audit_insert_row["insertion_date"]; ?></td>
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

        <!-- get dem gender stats -->
    

     <!-- get rep gender stats-->
    <?php
          if (isset($_POST['audit_delete_submit'])) {

            if ($audit_delete_result && $prepared_stmt_audit_delete->rowCount() > 0) { ?>
                 <!-- first show the header RESULT -->
              <h2>Audit Update Table</h2>
              <table>
                <thead>
                  <tr>
                    <th>Voter Reg Num</th>
                    <th>Party Code</th>
                    <th>Gender</th>
                    <th>Full name</th>
                    <th>Registration Date</th>
                    <th>Delete TimeStamp</th>
                  </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody>
                  <?php foreach ($audit_delete_result as $audit_delete_row) { ?>
                
                    <tr>
                      <td><?php echo $audit_delete_row["voter_reg_num"]; ?></td>
                      <td><?php echo $audit_delete_row["party_cd"]; ?></td>
                      <td><?php echo $audit_delete_row["sex_code"]; ?></td>
                      <td><?php echo $audit_delete_row["full_name_mail"]; ?></td>
                      <td><?php echo $audit_delete_row["registr_dt"]; ?></td>
                      <td><?php echo $audit_delete_row["delete_timestamp"]; ?></td>
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
 <!-- get switched voter number-->
      
    
  </body>
</html>


