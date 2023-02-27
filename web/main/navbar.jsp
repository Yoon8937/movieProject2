<%@ page import="model.UserDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>네이게이션 바</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    pageContext.setAttribute("logIn",logIn);
%>
</head>

<body>


<nav class="navbar navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="/main/home.jsp">영화 관리 프로그램</a>
        <ul class="nav nav-pills">
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/main/movie/movie_home.jsp">Movie</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/main/theater/theater_main.jsp">Theater</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/member/rankup.jsp">등업신청[${logIn.nickname}(${logIn.rank})]</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="/logout_logic.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>

</body>
</html>

