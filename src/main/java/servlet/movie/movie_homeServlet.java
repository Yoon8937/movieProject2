package servlet.movie;

import com.google.gson.JsonArray;
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
import javax.swing.plaf.basic.BasicOptionPaneUI;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.ConcurrentModificationException;

@WebServlet(name = "movie_homeServlet", value = "/movie/movie_homeServlet")
public class movie_homeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("hello world");
        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        int pageNo = Integer.parseInt(request.getParameter("pageNo"));

        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);
        MovieController movieController = new MovieController(connectionMaker);

        ArrayList<MovieDTO> list = movieController.selectAll(pageNo);

        int totalPage = movieController.countTotalPage();
        System.out.println("토탈 : "+ totalPage);

        JsonArray array = new JsonArray();

        for(MovieDTO m : list){
            JsonObject obj = new JsonObject();
            obj.addProperty("id",m.getId());
            obj.addProperty("title", m.getTitle());
            obj.addProperty("story", m.getStory());
            obj.addProperty("rank", m.getRank());
            obj.addProperty("isOwned","관리자".equals(m.getRank()));

            array.add(obj);
        }

        JsonObject result = new JsonObject();
        result.addProperty("result", "success");
        result.addProperty("data", array.toString());
        result.addProperty("totalPage", totalPage);

        result.addProperty("id",logIn.getId());
        result.addProperty("username", logIn.getUsername());
        result.addProperty("nickname", logIn.getNickname());

        boolean isAdmin = false;
        if("관리자".equals(logIn.getRank())) {
            isAdmin = true;
        } else {
            isAdmin = false;
        }
        result.addProperty("isAdmin", isAdmin);

        response.setCharacterEncoding("UTF-8");
        PrintWriter writer = response.getWriter();
        writer.print(result);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
