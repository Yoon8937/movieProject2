package servlet;

import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;

@WebServlet(name = "GetLoginServlet", value = "/auth/getLogin")
public class GetLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter writer = response.getWriter();
        JsonObject obj = new JsonObject();
        String status = "";

        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");

        obj.addProperty("id",logIn.getId());
        obj.addProperty("username", logIn.getUsername());
        obj.addProperty("nickname", logIn.getNickname());
        obj.addProperty("rank", logIn.getRank());

        writer.print(obj);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
