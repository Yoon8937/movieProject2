<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserDTO" %>
<%@ page import="com.mysql.cj.protocol.Resultset" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectionMaker" %>
<%@ page import="controller.MovieController" %>
<%@ page import="model.MovieDTO" %>
<%@ page import="controller.RatingController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.RatingDTO" %>
<%@ page import="controller.UserController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if(logIn == null){
            response.sendRedirect("/login.jsp");
        }

        int movieId = Integer.parseInt(request.getParameter("movieId"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        MovieController movieController = new MovieController(connectionMaker);
        RatingController ratingController = new RatingController(connectionMaker);
        UserController userController = new UserController(connectionMaker);

        MovieDTO movieDTO = movieController.selectOne(movieId);
        ArrayList<RatingDTO> ratingList = ratingController.selectAll(movieId);

        pageContext.setAttribute("ratingList", ratingList);
        pageContext.setAttribute("userController",userController);
        pageContext.setAttribute("logIn", logIn);
        pageContext.setAttribute("movieId",movieId);

    %>

    <script>
        function delete_rating(id, movieId) {
            let result = confirm(id+"번 평론 또는 평가를 삭세하실 건가요?")
            if(result){
                location.href = "/main/movie/delete_review_logic.jsp?ratingId=" + id + "&movieId=" + movieId
            }
        }
    </script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js%20library/build/ckeditor.js"></script>

    <script src="/assets/js/movie/printOneMovie.js"></script>

<%--    <title><%=movieDTO.getTitle()%></title>--%>
    <title></title>
</head>
<body onload="printOneMethod()">
<c:import url="/main/movie_navbar.jsp"/>

<main class="mb-4">
    <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <c:choose>
                    <c:when test="${logIn.rank eq '관리자'}">
                        <table>
                            <tr>
                                <th>번호</th>
                                    <%--                <td><input type="text" id="input-id"><%=movieDTO.getId()%></td>--%>
                                <td><input type="text" id="input-id"></td>
                            </tr>
                            <tr>
                                <th>영화제목</th>
                                <td><input type="text" id="input-title"></td>
                            </tr>
                            <tr>
                                <th>	영화 등급</th>
                                <td><input type="text" id="input-rank"></td>
                            </tr>

                            <tr>
                                <td>
                                    <textarea name="story" id="editor"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="btn btn-outline-primary"onclick="updateMovie()">수정하기</div>
                                </td>
                            </tr>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <table>
                                <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>영화제목</th>
                                    <th>제목</th>
                                    <th>영화 등급</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><%=movieDTO.getId()%></td>
                                    <td><%=movieDTO.getTitle()%></td>
                                    <td><%=movieDTO.getStory()%></td>
                                    <td><%=movieDTO.getRank()%></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <br>
    <br>
    <br>
    <br>

    <div class="container px-4 px-lg-5">
        <div class="row gx-4 gx-lg-5 justify-content-center">
            <div class="col-md-10 col-lg-8 col-xl-7">
                <table>
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>닉네임</th>
                        <th>평점</th>
                        <th>평론</th>
                    </tr>

                    <tr>
                        <td>
                            <table id="table-review">
                                <tbody id="tbody-review">
                                <tr>
                                    <td>
                                        <input type="text" id="score" placeholder="평점을 입력해주세요.">
                                    </td>
                                    <c:if test="${logIn.rank eq '평론가'}">
                                        <td>
                                            <input type="text" id="review" placeholder="평론을 입력해주세요.">
                                        </td>
                                    </c:if>
                                    <td>
                                        <div class="btn btn-outline-dark" onclick="writeReview()">등록</div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>

                    </thead>
                    <tbody id="test">
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








