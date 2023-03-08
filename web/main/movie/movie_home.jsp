<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.MovieController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.MovieDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>영화전체</title>
  <%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if(logIn == null){
      response.sendRedirect("/login.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    MovieController movieController = new MovieController(connectionMaker);
//    ArrayList<MovieDTO> list = movieController.selectAll();
//
//    pageContext.setAttribute("list",list);
    pageContext.setAttribute("logIn",logIn);
  %>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <script src="/assets/js/movie/movie_home.js"></script>

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

<body onload="initPage()">
  <c:import url="/main/movie_navbar.jsp"/>

  <main class="mb-4">
    <div class="container px-4 px-lg-5">
      <div class="row gx-4 gx-lg-5 justify-content-center">
        <div class="col-md-10 col-lg-8 col-xl-7">
          <table class="table table-borderless">
            <thead>
            <tr>
              <th>번호</th>
              <th>제목</th>
              <th>줄거리</th>
              <th>등급</th>
              <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td id="td-pagination"></td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </main>



<%--  <c:if test="${logIn.rank eq '관리자'}">--%>
<%--    <div>--%>
<%--      <caption>새로운 영화 등록하기</caption>--%>
<%--      <form action="/main/movie/insert_movie_logic.jsp" method="post">--%>
<%--        <table>--%>

<%--          <tbody>--%>
<%--          <tr>--%>
<%--            <th>제목</th>--%>
<%--            <td><input type="text" name="title"></td>--%>
<%--          </tr>--%>
<%--          <tr>--%>
<%--            <th>줄거리</th>--%>
<%--            <td><textarea name="story"></textarea></td>--%>
<%--          </tr>--%>
<%--          <tr>--%>
<%--            <th>영화등급</th>--%>
<%--            <td><input type="text" name="rank"></td>--%>
<%--          </tr>--%>
<%--          <tr>--%>
<%--            <td>--%>
<%--              <button>영화등록</button>--%>
<%--            </td>--%>
<%--          </tr>--%>
<%--          </tbody>--%>
<%--        </table>--%>
<%--      </form>--%>
<%--    </div>--%>
<%--  </c:if>--%>

  <c:import url="/footer.jsp"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Core theme JS-->
  <script src="/js/scripts.js"></script>
</body>
</html>
