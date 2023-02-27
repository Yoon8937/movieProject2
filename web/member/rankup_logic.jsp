<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>rankup logic page</title>
</head>

<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int ask_rank = Integer.parseInt(request.getParameter("ask_rank"));

        String askRank = "";
        if(ask_rank==1 || ask_rank==2){
            askRank = "일반 관람객";
        } else if(ask_rank==3){
            askRank = "평론가";
        } else if(ask_rank==4){
            askRank = "관리자";
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        System.out.println("무야호 "+id +" , "+askRank);

        userController.ask_RankUp(id, askRank);

        response.sendRedirect("/member/rankup.jsp");
    %>
</body>
</html>
