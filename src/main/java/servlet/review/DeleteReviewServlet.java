package servlet.review;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.MovieController;
import controller.RatingController;
import model.MovieDTO;
import model.RatingDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteReviewServlet", value = "/review/delete")
public class DeleteReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("무야호호호ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ");
        PrintWriter writer = response.getWriter();
        JsonObject obj = new JsonObject();
        String status = "";

        try{
        System.out.println("무야호호호ㅗㅗㅗㅗㅗ2222222ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ");
            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) (session.getAttribute("logIn"));

            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("id : "+id);
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            RatingController ratingController = new RatingController(connectionMaker);
//            RatingDTO r = ratingController.selectOne(id);
//            System.out.println("r : "+r);
//
//            if(r == null){
//                System.out.println("삭제 서블릿에서 예외가 발생했습니다.");
//                throw new NullPointerException();
//            }

            ratingController.delete(id);
            status = "success";
            System.out.println("status : "+status);

        } catch (Exception e){
            status = "fail";
        }

        System.out.println(status);
        obj.addProperty("status",status);
        writer.print(obj);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
