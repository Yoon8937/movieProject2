<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="java.awt.desktop.UserSessionEvent" %>
<%@ page import="controller.UserController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%--    <%--%>
<%--    아마 alert를 띄우는 순간에 컷밋하는데 redirect가 떠서 오류난듯--%>
<%--        UserDTO logIn = (UserDTO) session.getAttribute("logIn");--%>
<%--        if(logIn == null){--%>
<%--            System.out.println("register_logic입니다. : ");--%>
<%--            response.sendRedirect("/login.jsp");--%>
<%--        }--%>
<%--    %>--%>
    <title>회원등록 로직</title>
</head>

<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String nickname = request.getParameter("nickname");

    UserDTO userDTO = new UserDTO();
    userDTO.setUsername(username);
    userDTO.setPassword(password);
    userDTO.setNickname(nickname);

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    boolean result = userController.insert(userDTO);

    if(result) {
        response.sendRedirect("/login.jsp");
    } else {
%>
    <script>
        alert("중복된 아이디로 가입하실 수 없습니다.");
        history.go(-1);
    </script>
<%
    }
%>
</body>
</html>
