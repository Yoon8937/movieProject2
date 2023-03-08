<%@ page import="model.UserDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>네이게이션 바</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Clean Blog - Start Bootstrap Theme</title>
  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
  <link href="/css/styles.css" rel="stylesheet" />
  <%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    pageContext.setAttribute("logIn",logIn);
  %>
</head>

<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
  <div class="container px-4 px-lg-5">
    <a class="navbar-brand" href="/main/home.jsp">영화 관리 프로젝트</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      Menu
      <i class="fas fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ms-auto py-4 py-lg-0">
        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="/main/movie/movie_home.jsp">Movie</a></li>
        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="/main/theater/theater_main.jsp">Theater</a></li>
        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="/member/rankup.jsp">RankUp</a></li>
        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="/logout_logic.jsp">LogOut</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Page Header-->
<header class="masthead" style="background-image: url('/movie.jpg')">
  <div class="container position-relative px-4 px-lg-5">
    <div class="row gx-4 gx-lg-5 justify-content-center">
      <div class="col-md-10 col-lg-8 col-xl-7">
        <div class="page-heading">
          <h1>M O V I E</h1>
          <span class="subheading">웃어라, 온 세상이 너와 함께 웃을 것이다,</span>
          <span class="subheading">울어라, 너 혼자만 울게 될 것이다.</span>

        </div>
      </div>
    </div>
  </div>
</header>

</body>
</html>

