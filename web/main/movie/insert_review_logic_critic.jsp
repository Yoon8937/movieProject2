<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.RatingController" %>
<%@ page import="model.RatingDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>insert_review_logic_critic</title>
</head>
<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int id = logIn.getId();
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        float score = Float.parseFloat(request.getParameter("score"));
        String review = request.getParameter("review");


        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        RatingController ratingController = new RatingController(connectionMaker);

        RatingDTO r = new RatingDTO();
        r.setWriteId(id);
        r.setMovieId(movieId);
        r.setScore(score);
        r.setReview(review);
        System.out.println(r);

        ratingController.insert(r);

        response.sendRedirect("/main/movie/printOneMovie.jsp?movieId=" + movieId);

    %>
</body>
</html>
