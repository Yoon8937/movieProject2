<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 삭제 로직</title>
</head>
<body>
<%
  UserDTO logIn = (UserDTO) session.getAttribute("logIn");
  if(logIn == null){
    response.sendRedirect("/login.jsp");
  } else if(!(logIn.getRank().equals("관리자"))){
    response.sendRedirect("/login.jsp");
  }

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectionMaker();
  UserController userController = new UserController(connectionMaker);

  userController.delete(id);

  response.sendRedirect("/member/userList.jsp");
%>

</body>
</html>
