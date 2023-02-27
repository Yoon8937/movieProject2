<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="model.MovieDTO" %>
<%@ page import="controller.MovieController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 생성 로직</title>
</head>

<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        MovieController movieController = new MovieController(connectionMaker);
        MovieDTO m = new MovieDTO();

        m.setTitle(request.getParameter("title"));
        m.setStory(request.getParameter("story"));
        m.setRank(request.getParameter("rank"));
        movieController.insert(m);

        response.sendRedirect("/main/movie/movie_home.jsp");
    %>
</body>
</html>
