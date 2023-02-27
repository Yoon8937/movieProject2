<%@ page import="model.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃 로직</title>
</head>

<body>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        session.invalidate();

        response.sendRedirect("/login.jsp");
    %>

</body>
</html>
