<%@ page import="model.UserDTO" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>insert_new_theater_logic</title>
</head>

<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);

        String name = request.getParameter("name");
        String location = request.getParameter("location");
        String tel = "1544-1122";

        TheaterDTO t  = new TheaterDTO();
        t.setName(name);
        t.setLocation(location);
        t.setTel(tel);

        theaterController.insert(t);

        response.sendRedirect("/main/theater/theater_main.jsp");
    %>
</body>
</html>
