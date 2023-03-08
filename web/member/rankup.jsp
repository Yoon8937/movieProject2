<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if(logIn == null){
      response.sendRedirect("/login.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    UserDTO u = userController.selectOne(logIn.getId());

    pageContext.setAttribute("u",u);
  %>

    <title><%=logIn.getNickname()%> 님</title>
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
<c:import url="/main/navbar.jsp"/>
<!-- Page Header-->
<header class="masthead" style="background-image: url('/movie.jpg')">
  <div class="container position-relative px-4 px-lg-5">
    <div class="row gx-4 gx-lg-5 justify-content-center">
      <div class="col-md-10 col-lg-8 col-xl-7">
        <div class="page-heading">
          <h1>R A N K U P</h1>
          <span class="subheading">This is RankUp Page. </span>
        </div>
      </div>
    </div>
  </div>
</header>

<!-- Main Content-->
<main class="mb-4">
<%--  <div class="container px-4 px-lg-5">--%>
<%--    <div class="row gx-4 gx-lg-5 justify-content-center">--%>
<%--      <div class="col-md-10 col-lg-8 col-xl-7">--%>
<%--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe nostrum ullam eveniet pariatur voluptates odit, fuga atque ea nobis sit soluta odio, adipisci quas excepturi maxime quae totam ducimus consectetur?</p>--%>
<%--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius praesentium recusandae illo eaque architecto error, repellendus iusto reprehenderit, doloribus, minus sunt. Numquam at quae voluptatum in officia voluptas voluptatibus, minus!</p>--%>
<%--        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aut consequuntur magnam, excepturi aliquid ex itaque esse est vero natus quae optio aperiam soluta voluptatibus corporis atque iste neque sit tempora!</p>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>

  <div class="container px-4 px-lg-5">
    <div class="row gx-4 gx-lg-5 justify-content-center">
      <div class="col-md-10 col-lg-8 col-xl-7">
        <caption>등업 신청하기</caption>
        <table class="table table-borderless">
          <thead>
          <tr>
            <th>번호</th>
            <th>아이디</th>
            <th>닉네임</th>
            <th>현재등급</th>
            <th>등업하고 싶은 등급</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td><%=u.getId()%></td>
            <td><%=u.getUsername()%></td>
            <td><%=u.getNickname()%></td>
            <td><%=u.getRank()%></td>
            <c:if test="${u.id ne 1}">
              <td>
                <div>
                  <form action="/member/rankup_logic.jsp">
                    <input type="hidden" name="id" value="${u.id}">
                    <select name="ask_rank">
                      <option value=1 selected><%=u.getRank()%>
                      <option value=2>일반 관람객
                      <option value=3>평론가
                      <option value=4>관리자
                    </select>
                    <button>신청</button>
                  </form>
                </div>
              </td>
            </c:if>
          </tr>
          </tbody>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
  </div>


</main>

<c:import url="/footer.jsp"/>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/js/scripts.js"></script>



</body>
</html>
