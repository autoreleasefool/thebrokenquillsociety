<?php
  // Create a session and check if the user is logged in
	session_start();
	$name = "";
	$userid = "";
	if(array_key_exists('name', $_SESSION) && array_key_exists('userid', $_SESSION)){
		$name = $_SESSION['name'];
		$userid = $_SESSION['userid'];
	}
?>

<!DOCTYPE HTML>
<html lang="en">

  <!-- HEAD begins -->
  <head>
    <?php $page_title = "Home" ?>
  	<?php include("includes/resources.php");?>
  </head>
  <!-- HEAD ends -->

  <!-- BODY begins -->
  <body>

    <!-- import header -->
    <?php include("includes/header.php");?>

    <div class="index-banner">
    </div>

    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
  </body>
  <!-- BODY ends -->

  <!-- import JavaScript -->
  <!-- Loaded at end to improve ux -->
  <?php include("includes/js.php");?>
</html>
