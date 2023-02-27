<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="model.MovieDTO" %>
<%@ page import="controller.MovieController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int theaterId = Integer.parseInt(request.getParameter("theaterId"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);
        MovieController movieController = new MovieController(connectionMaker);
        ArrayList<MovieDTO> movieList = movieController.selectTheaterAllMovies(theaterId);
        System.out.println("영화관 영화리스트"+movieList);


        TheaterDTO t = theaterController.selectOne(theaterId);

        pageContext.setAttribute("theaterController", theaterController);
        pageContext.setAttribute("movieList",movieList);

    %>
    <title>
        <%=t.getName()%>
    </title>
</head>

<body>
    <c:import url="/main/navbar.jsp"/>
    <h1>this is moive PrintOne page.</h1>
    <table>
        <thead>
            <tr style="font-size: 30px">
                <th>번호</th>
                <th>제목</th>
                <th>위치</th>
                <th>전화번호</th>
            </tr>
        </thead>
        <tbody>
            <tr style="font-size: 30px;">
               <c:set var="t" value="<%=movieList%>" />
                <td><%=t.getId()%></td>
                <td><%=t.getName()%></td>
                <td><%=t.getLocation()%></td>
                <td><%=t.getTel()%></td>
            </tr>
        </tbody>
    </table>

<br>
<br>
<br>

    <c:choose>
<%--        <c:when test="${movieList.isEmpty()}">--%>
        <c:when test="${movieList.isEmpty()}">
            <span>아직 등록된 영화가 없습니다.</span>
        </c:when>
        <c:otherwise>
            <table>
                    <%--    <table style="table-layout: fixed">--%>
                <caption>해당 극장 상영중인 영화 목록</caption>
                <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>줄거리</th>
                    <th>등급</th>
                    <th>상세보기</th>
                </tr>
                </thead>
                <tbody >
                <c:forEach var="t" items="${movieList}">
                    <tr >
                        <td>${t.id}</td>
                        <td>${t.title}</td>
                        <td style="width:280px;height:20px; text-overflow:ellipsis; display: block; overflow:hidden;">${t.story}</td>
                        <td>${t.rank}</td>
                        <td>
                            <button type="button" onclick="print_one_movie_method(${t.id})">자세히 보기</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <script>
        function print_one_movie_method(movieId) {
            location.href = "/main/movie/printOneMovie.jsp?movieId=" + movieId
        }
    </script>
</body>
</html>





















