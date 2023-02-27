<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="model.UserDTO" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }


        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);
        ArrayList<TheaterDTO> list = theaterController.selectAll();


        pageContext.setAttribute("list",list);
        pageContext.setAttribute("logIn", logIn);
    %>
    <title>영화관 메인</title>

    <style>
        table, th, td {
            border:1px solid #ccc;
            border-collapse: collapse;
        }
        th, td { padding:10px 20px; }
    </style>

</head>

<body>
  <c:import url="/main/navbar.jsp"/>
  <h1>tthis is theater main page.</h1>

<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>상영관 이름</th>
            <th>위치</th>
            <th>전화번호</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="t" items="${list}">
<%--            <tr style="font-size: 30px;">--%>
            <tr onclick="location.href='/main/theater/theaterPrintOne.jsp?theaterId=${t.id}'" style="font-size: 30px;">
                <td>${t.id}</td>
                <td>${t.name}</td>
                <td>${t.location}</td>
                <td>${t.tel}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<br>
<br>
<br>

<c:if test="${logIn.rank eq '관리자'}">
    <div>
        <form action="/main/theater/insert_new_theater_logic.jsp">
            <table>
                <caption>새로운 상영관 등록하기</caption>
                <thead>
                <tr>
                    <th>상영관 이름</th>
                    <th>위치</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <input type="text" name="name" placeholder="등록할 CGV상영관">
                    </td>
                    <td>
                        <input type="text" name="location" placeholder="위치를 입력해주세요">
                    </td>
                    <td><button>등록</button></td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</c:if>


</body>
</html>




















