<%@ page import="model.UserDTO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.MovieController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 삭제 로직</title>
</head>

<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int movieId = Integer.parseInt(request.getParameter("movieId"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        MovieController movieController = new MovieController(connectionMaker);
        movieController.delete(movieId);

        response.sendRedirect("/main/movie/movie_home.jsp");
    %>
</body>
</html>
