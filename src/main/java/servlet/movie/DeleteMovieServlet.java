package servlet.movie;

import com.google.gson.JsonObject;
import com.mysql.cj.jdbc.exceptions.ConnectionFeatureNotAvailableException;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.MovieController;
import model.MovieDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.CompactNumberFormat;

@WebServlet(name = "DeleteMovieServlet", value = "/movie/delete")
public class DeleteMovieServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();

        JsonObject obj = new JsonObject();
        String status = "";

        try{
            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) (session.getAttribute("logIn"));

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            MovieController movieController = new MovieController(connectionMaker);
            MovieDTO m = movieController.selectOne(id);

            if(m == null){
                System.out.println("삭제 서블릿에서 예외가 발생했습니다.");
                throw new NullPointerException();

            }

            movieController.delete(id);
            status = "success";

        } catch (Exception e){
            status = "fail";
        }

        obj.addProperty("status",status);
        writer.print(obj);




    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
