<%@ page import="model.UserDTO" %>
<%@ page import="controller.UserController" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.MovieController" %>
<%@ page import="controller.RatingController" %>
ㄴㄴ<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 삭제 로직</title>
</head>
<body>
    <h1>Hello World</h1>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int ratingId = Integer.parseInt(request.getParameter("ratingId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));


        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        RatingController ratingController = new RatingController(connectionMaker);
        ratingController.delete(ratingId);

        response.sendRedirect("/main/movie/printOneMovie.jsp?movieId="+movieId);
    %>

<%--    <script>--%>
<%--        history.go(-1);--%>
<%--    </script>--%>
</body>
</html>
