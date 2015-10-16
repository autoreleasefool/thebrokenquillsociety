<header class="nav-down">
  <!-- begin website title -->
  <div class="header-title">
    <h1>
      <?php
        if ($page_title == "Home")
          echo "<a href='#'>CWC</a>";
        else
          echo "<a href='index.php'>CWC</a>";
      ?>
    </h1>
  </div>
  <!-- end website title -->

  <!-- Check if user logged in - shows either login or profile picture -->
  <?php
    if (array_key_exists("name", $_SESSION) && array_key_exists("userid", $_SESSION)) {
      // User is logged in, show their profile picture and a "new submission" button
      // TODO: replace following echo
      echo "<h1>error, logged in header not implemented</h1>";
    } else {
      // User is not logged in, so display a sign up / login button
      echo "<div class='header-login'><a href='login.php'><div class='header-login-btn'>Login</div></a></div>";
    }
  ?>

  <!-- begin search box -->
  <div class="search-box">
    <div class="search-container">
      <span class="icon"><i class="fa fa-search"></i></span>
      <input type="search" id="search" placeholder="Search..." />
    </div>
  </div>
  <!-- end search box -->

</header>
