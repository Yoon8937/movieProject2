package servlet.movie;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.RatingController;
import controller.UserController;
import model.RatingDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;

@WebServlet(name = "ReviewServlet", value = "/movie/review")
public class ReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();

        int movieId = Integer.parseInt(request.getParameter("movieId"));

        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);
        RatingController ratingController = new RatingController(connectionMaker);





        ArrayList<RatingDTO> list = ratingController.selectAll(movieId);

        JsonArray arr = new JsonArray();
        boolean isOwned = false;
        boolean isCritic = false;
//
        for(RatingDTO r : list){
            JsonObject obj = new JsonObject();
            obj.addProperty("id",r.getId());
            obj.addProperty("writeId",r.getWriteId());
//            obj.addProperty("movieId",r.getMovieId());
            obj.addProperty("score",r.getScore()+"");
            obj.addProperty("review", r.getReview());
            obj.addProperty("isOwned", r.getWriteId() == logIn.getId());

            String rank = userController.selectOne(logIn.getId()).getRank();
            obj.addProperty("isCritic", "평론가".equals(rank));
            arr.add(obj);
        }
//
        JsonObject result = new JsonObject();
        result.addProperty("status", "success");
        result.addProperty("data", arr.toString());

        writer.print(result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
