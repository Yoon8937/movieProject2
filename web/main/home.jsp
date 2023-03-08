<%@ page import="model.UserDTO" %>
<%@ page import="jdk.jshell.spi.ExecutionControl" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }
        pageContext.setAttribute("logIn", logIn);

    %>
    <title>메인화면</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<%--    <link rel="stylesheet" type="text/css" href="footer.css">--%>
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
<header class="masthead" style="background-image: url('/1161069.jpg')">
    <div class="container position-relative px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <div class="site-heading">
                    <h1>영화 관리 프로젝트</h1>
                    <span class="subheading">
                        <MARQUEE behavior="scroll" scrolldelay="1">Welcome! 환영합니다! Bienvenue! いらっしゃいませ!</MARQUEE>
<%--                        <MARQUEE behavior="scroll" scrolldelay="1">Hello! 안녕하세요! Bonjour! こんにちは! Hola! 你好!</MARQUEE>--%>
                    </span>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main Content-->
<div class="container px-4 px-lg-5">
    <div class="row gx-4 gx-lg-5 justify-content-center">
        <div class="col-md-10 col-lg-8 col-xl-7">
            <!-- Post preview-->
            <div class="post-preview">
                <a href="/main/movie/movie_home.jsp">
                    <h2 class="post-title">영화보기</h2>
                    <h3 class="post-subtitle">다양한 영화들을 만나보고, 평점 및 평론도 함께 확인해보세요.</h3>
                </a>
                <p class="post-meta">
                    Posted by
                    <a href="/main/movie/movie_home.jsp">Start Bootstrap</a>
                    on March 7, 2023
                </p>
            </div>

            <!-- Divider-->
            <hr class="my-4" />
            <!-- Post preview-->
            <div class="post-preview">
                <a href="/main/theater/theater_main.jsp">
                    <h2 class="post-title">극장 찾아보기</h2>
                    <h3 class="post-subtitle">나에게 가까운 CGV극장을 찾아보세요.</h3>
                </a>
                <p class="post-meta">
                    Posted by
                    <a href="">Start Bootstrap</a>
                    on March 7, 2023
                </p>
            </div>
            <!-- Divider-->

<%--            <hr class="my-4" />--%>
<%--            <!-- Post preview-->--%>
<%--            <div class="post-preview">--%>
<%--                <a href="post.html">--%>
<%--                    <h2 class="post-title">Failure is not an option</h2>--%>
<%--                    <h3 class="post-subtitle">Many say exploration is part of our destiny, but it’s actually our duty to future generations.</h3>--%>
<%--                </a>--%>
<%--                <p class="post-meta">--%>
<%--                    Posted by--%>
<%--                    <a href="#!">Start Bootstrap</a>--%>
<%--                    on July 8, 2022--%>
<%--                </p>--%>
<%--            </div>--%>
            <!-- Divider-->
            <hr class="my-4" />
            <!-- Pager-->
            <c:if test="${logIn.rank eq '관리자'}">
                <div class="d-flex justify-content-end mb-4"><a class="btn btn-primary text-uppercase" href="/member/userList.jsp">회원관리(관리자전용) →</a></div>
            </c:if>
        </div>
    </div>
</div>

<c:import url="/footer.jsp"/>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/js/scripts.js"></script>
</body>
</html>
