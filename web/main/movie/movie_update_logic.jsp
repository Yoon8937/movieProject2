<%@ page import="model.UserDTO" %>
<%@ page import="com.mysql.cj.x.protobuf.MysqlxExpr" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.MovieController" %>
<%@ page import="model.MovieDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>영화 내용 수정</title>
</head>
<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        MovieController movieController = new MovieController(connectionMaker);


        MovieDTO movieDTO = new MovieDTO();
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        movieDTO.setId(movieId);
        movieDTO.setTitle(request.getParameter("title"));
        movieDTO.setStory(request.getParameter("story"));
        movieDTO.setRank(request.getParameter("rank"));
        movieController.update(movieDTO);
        response.sendRedirect("/main/movie/printOneMovie.jsp?movieId=" + movieId);
    %>
</body>
</html>
