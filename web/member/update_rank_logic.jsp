<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 등급 로직</title>
</head>
<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));
        int rank = Integer.parseInt(request.getParameter("rank"));

        String newRank = "";
        if(rank==1 || rank==2){
            newRank = "일반 관람객";
        } else if(rank==3){
            newRank = "평론가";
        } else if(rank==4){
            newRank = "관리자";
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);
        System.out.println("무야호 " +id+", "+newRank);
        userController.update(id, newRank);

        response.sendRedirect("/member/userList.jsp");

    %>
</body>
</html>
