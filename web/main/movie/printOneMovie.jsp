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

    <title><%=movieDTO.getTitle()%></title>
</head>
<body>
<c:import url="/main/navbar.jsp"/>

  <h1>영화 개별보기 입니다.</h1>

  <c:choose>
      <c:when test="${logIn.rank ne '관리자'}">
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
      </c:when>
      <c:otherwise>
          <div>
              <form action="/main/movie/movie_update_logic.jsp">
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
                          <td>
                              <input type="hidden" name="movieId" value="${movieId}">
                              <input type="text" name="title" value="<%=movieDTO.getTitle()%>">
                          </td>
                          <td>
                          <textarea name="story">
                              <%=movieDTO.getStory()%>
                          </textarea>
                          </td>
                          <td>
                              <input type="text" name="rank" value="<%=movieDTO.getRank()%>">
                          </td>
                      </tr>
                      </tbody>
                      <tfoot>
                      <tr>
                          <td>
                              <button>수정하기</button>
                          </td>
                      </tr>
                      </tfoot>
                  </table>
              </form>

          </div>
      </c:otherwise>
  </c:choose>

    <br>
    <br>
    <br>



  <div>
      <c:set var="logIn" value="<%=logIn%>"/>
<%--      <form>--%>
          <caption><h1>평론 및 평가입니다.</h1></caption>
          <table>
              <thead>
              <tr>
                  <th>번호</th>
                  <th>닉네임</th>
                  <th>평점</th>
                  <th>리뷰</th>

              </tr>
              </thead>

              <tbody>
              <c:choose>
                  <c:when test="${empty ratingList}">
                      <tr>
                          <td><h1>아직 등록되 평론 또는 평가가 없습니다.</h1></td>
                      </tr>
                  </c:when>
                  <c:otherwise>
                      <c:forEach items="${ratingList}" var="ratingDTO">
                          <tr>
                              <td>${ratingDTO.id}</td>
                              <td>${userController.selectOne(ratingDTO.writeId).nickname}[${userController.selectOne(ratingDTO.writeId).rank}]</td>
                              <td>${ratingDTO.score}</td>
                              <td>
                                  <c:choose>
                                      <c:when test="${logIn.id ne userController.selectOne(ratingDTO.writeId).id}">
                                          ${ratingDTO.review}
                                      </c:when>
                                      <c:otherwise>
                                          <c:if test="${logIn.rank eq '평론가'}">

                                                <textarea>
                                                        ${ratingDTO.review}
                                                </textarea>
                                              <button>수정</button>
                                              <span class="btn btn-outline-danger"
                                                    onclick="delete_rating(${ratingDTO.id},<%=movieId%>)">
                                              <button>삭제</button>
                                          </span>
                                          </c:if>
                                      </c:otherwise>
                                  </c:choose>
                              </td>
                          </tr>
                      </c:forEach>
                  </c:otherwise>
              </c:choose>
              </tbody>

          </table>
  </div>


<br>
<br>
<br>

    <c:choose>
        <c:when test="${logIn.rank eq '평론가'}">
            <div>
                <form action="/main/movie/insert_review_logic_critic.jsp">
                    <table>
                        <caption>평론 및 평점 등록하기</caption>
                        <thead>
                        <tr>
                            <th>평점</th>
                            <th>평론</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input type="hidden" name="movieId" value="${movieId}">
                                <input type="hidden" name="id" value="${logIn.id}">
                                <input type="text" name="score">
                            </td>
                            <td><textarea name="review"></textarea></td>
                            <td><button>등록</button></td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div>
                <form action="/main/movie/insert_review_logic_critic.jsp">
                    <table>
                        <caption>평점 등록하기</caption>
                        <thead>
                        <tr>
                            <th>평점</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input type="hidden" name="movieId" value="${movieId}">
                                <input type="hidden" name="id" value="${logIn.id}">
                                <input type="text" name="score">
                            </td>
                            <td><button>등록</button></td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </c:otherwise>
    </c:choose>


</body>
</html>




























