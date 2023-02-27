<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if(logIn == null){
      response.sendRedirect("/login.jsp");
    }

    ConnectionMaker connectionMaker = new MySqlConnectionMaker();
    UserController userController = new UserController(connectionMaker);

    UserDTO u = userController.selectOne(logIn.getId());

    pageContext.setAttribute("u",u);
  %>

    <title><%=logIn.getNickname()%> 님</title>
</head>

<body>
  <c:import url="/main/navbar.jsp"/>

  <table>
    <caption>등업 신청하기</caption>
    <thead>
      <tr>
        <th>번호</th>
        <th>아이디</th>
        <th>닉네임</th>
        <th>현재등급</th>
        <th>등업하고 싶은 등급</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><%=u.getId()%></td>
        <td><%=u.getUsername()%></td>
        <td><%=u.getNickname()%></td>
        <td><%=u.getRank()%></td>
        <c:if test="${u.id ne 1}">
          <td>
            <div>
              <form action="/member/rankup_logic.jsp">
                <input type="hidden" name="id" value="${u.id}">
                <select name="ask_rank">
                  <option value=1 selected><%=u.getRank()%>
                  <option value=2>일반 관람객
                  <option value=3>평론가
                  <option value=4>관리자
                </select>
                <button>신청</button>
              </form>
            </div>
          </td>
        </c:if>

      </tr>
    </tbody>
    <tbody>
    </tbody>
  </table>

</body>
</html>
