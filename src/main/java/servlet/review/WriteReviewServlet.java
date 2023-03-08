package servlet.review;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.RatingController;
import model.RatingDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "WriteReviewServlet", value = "/review/write")
public class WriteReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject obj = new JsonObject();
        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        String status = "";

        try {
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            RatingController ratingController = new RatingController(connectionMaker);

            int movieId = Integer.parseInt(request.getParameter("movieId"));
            float score = Float.parseFloat(request.getParameter("score"));
            String review = request.getParameter("review");

            RatingDTO r = new RatingDTO();
            r.setMovieId(movieId);
            r.setWriteId(logIn.getId());
            r.setScore(score);
            if("평론가".equals(logIn.getRank())){
                r.setReview(review);
            }

            ratingController.insert(r);
        } catch (Exception e) {
            status = "fail";
        }
        obj.addProperty("status", status);
        writer.print(obj);

    }
}













