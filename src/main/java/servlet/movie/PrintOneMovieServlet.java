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

@WebServlet(name = "PrintOneMovieServlet", value = "/movie/printOne")
public class PrintOneMovieServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject obj = new JsonObject();
        
        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);
        MovieController movieController = new MovieController(connectionMaker);

        String message = "";
        String nextPath = "";
        try {
            int movieId = Integer.parseInt(request.getParameter("movieId"));

            MovieDTO movieDTO = movieController.selectOne(movieId);
            if(movieDTO == null ){
                message = "유효하지 않은 글 번호입니다.";
                nextPath = "/main/movie/movie_home.jsp";
                throw new NullPointerException();
            }


            JsonObject mJson = new JsonObject();
            mJson.addProperty("movieId", movieDTO.getId());
            mJson.addProperty("title", movieDTO.getTitle());
            mJson.addProperty("story", movieDTO.getStory());
            mJson.addProperty("rank", movieDTO.getRank());

            obj.addProperty("status", "success");
            obj.addProperty("data", mJson.toString());
        } catch(NullPointerException e){
            obj.addProperty("status", "fail");
            obj.addProperty("message", message);
            obj.addProperty("nextPath",nextPath);
        } catch (Exception e){
            message = "오류가 발생했습니다.";
            nextPath = "/main/movie/movie_home.jsp";
            obj.addProperty("status", "fail");
            obj.addProperty("message", message);
            obj.addProperty("nextPath", nextPath);
        }

        writer.print(obj);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
