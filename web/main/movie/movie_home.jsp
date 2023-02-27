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
    ArrayList<MovieDTO> list = movieController.selectAll();

    pageContext.setAttribute("list",list);
    pageContext.setAttribute("logIn",logIn);
  %>

  <script>
    function print_one_movie_method(movieId) {
      location.href = "/main/movie/printOneMovie.jsp?movieId=" + movieId
    }

    function delete_movie_method(movieId){
      let result = confirm(movieId+"번 영화를 정말로 삭제하겠습니까?");
      if(result){
          location.href = "/main/movie/delete_one_movie_logic.jsp?movieId=" + movieId
      }

    }
  </script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>

<body>
  <c:import url="/main/navbar.jsp"/>
  <h1>this is movie home</h1>

  <div>
    <c:choose>
      <c:when test="${list.isEmpty()}">
        <span>아직 등록된 영화가 없습니다.</span>
      </c:when>
      <c:otherwise>
        <table>
            <%--    <table style="table-layout: fixed">--%>
          <caption>영화 전체 목록</caption>
          <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>줄거리</th>
            <th>등급</th>
          </tr>
          </thead>
          <tbody >
          <c:forEach var="m" items="${list}">
            <tr >
              <td>${m.id}</td>
              <td>${m.title}</td>
              <td style="width:280px;height:20px; text-overflow:ellipsis; display: block; overflow:hidden;">${m.story}</td>
              <td>${m.rank}</td>
              <td>
                <button type="button" onclick="print_one_movie_method(${m.id})">자세히 보기</button>
              </td>
              <c:if test="${logIn.rank eq '관리자'}">
                <td>
                  <button type="button" onclick="delete_movie_method(${m.id})">삭제</button>
                </td>
              </c:if>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:otherwise>
    </c:choose>
  </div>


  <br>
  <br>
  <br>


  <c:if test="${logIn.rank eq '관리자'}">
    <div>
      <caption>새로운 영화 등록하기</caption>
      <form action="/main/movie/insert_movie_logic.jsp" method="post">
        <table>

          <tbody>
          <tr>
            <th>제목</th>
            <td><input type="text" name="title"></td>
          </tr>
          <tr>
            <th>줄거리</th>
            <td><textarea name="story"></textarea></td>
          </tr>
          <tr>
            <th>영화등급</th>
            <td><input type="text" name="rank"></td>
          </tr>
          <tr>
            <td>
              <button>영화등록</button>
            </td>
          </tr>
          </tbody>
        </table>
      </form>
    </div>
  </c:if>



</body>
</html>
