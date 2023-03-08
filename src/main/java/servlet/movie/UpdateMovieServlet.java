package servlet.movie;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.MovieController;
import controller.UserController;
import model.MovieDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateMovieServlet", value = "/movie/update")
public class UpdateMovieServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject obj = new JsonObject();

        String status = "";
        String nextPath = "";
        String message = "";

        try{
            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int movieId = Integer.parseInt(request.getParameter("movieId"));

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            MovieController movieController = new MovieController(connectionMaker);
            MovieDTO m = movieController.selectOne(movieId);

//            if(m == null || !("관리자".equals(logIn.getRank())) )
            if(m == null){
                throw new NullPointerException();
            }

            m.setTitle(request.getParameter("title"));
            m.setRank(request.getParameter("rank"));
            m.setStory(request.getParameter("story"));

            movieController.update(m);

            status = "success";
            message = "성공적으로 수행되었습니다.";
        } catch (Exception e) {
            status = "fail";
            nextPath = "/main/movie/movie_home.jsp";
            message = "오류가 발생했습니다.";
            e.printStackTrace();
        }

        obj.addProperty("status",status);
        obj.addProperty("message", message);
        obj.addProperty("nextPath", nextPath);

        writer.print(obj);
    }
}


















