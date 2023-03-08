<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="java.nio.channels.MulticastChannel" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.UserController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원관리</title>
    <%--    회원등급변경 드롭다운?으로 구현해보기--%>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
//    if((!(logIn.getRank().equals("관리자"))) || logIn == null){//근데 왜 이렇게하면 안되냐

        if(logIn == null){
            response.sendRedirect("/login.jsp");
        } else if(!(logIn.getRank().equals("관리자"))){
            response.sendRedirect("/login.jsp");
        }

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        ArrayList<UserDTO> list = userController.selectAll();


        pageContext.setAttribute("list",list);
    %>

    <script>
        function delete_user(id) {
            let result = confirm(id+"번 회원을 정말로 삭제하시겠습니까?")
            if(result){
                location.href = "/member/delete.jsp?id=" + id
            }
        }

        function method(name) {
            // var s = document.getElementById("rank");
            // var r = s.options[s.selectedIndex].value;
            location.href = "/test.jsp?rank=" + name

        }
    </script>
</head>
<body>
<c:import url="/main/movie_navbar.jsp"/>

<main class="mb-4">
    <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <table>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>아이디</th>
                        <th>닉네임</th>
                        <th>등급</th>
                        <th></th>
                        <th>등업신청</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${list}">
                        <tr>
                            <td>${u.id}</td>
                            <td>${u.username}</td>
                            <td>${u.nickname}</td>
                            <td>
                                <div>
                                    <form action="/member/update_rank_logic.jsp">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <select name="rank" id="rank">
                                            <option value=1 selected>${u.rank}
                                            <option value=2>일반 관람객
                                            <option value=3>평론가
                                            <option value=4>관리자
                                        </select>
                                        <button>수정</button>
                                    </form>
                                </div>
                            </td>



                            <td>
                                <c:choose>
                                    <c:when test="${u.id == 1}">
                                        <span>삭제불가</span>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="btn btn-outline-danger" onclick="delete_user(${u.id})">삭제</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${u.ask}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</main>


<c:import url="/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="/js/scripts.js"></script>
</body>
</html>
