package servlet;

import com.google.gson.JsonObject;
import com.mysql.cj.protocol.Resultset;
import connector.ConnectionMaker;
import connector.MySqlConnectionMaker;
import controller.UserController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

//@WebServlet(name = "UserValidateServlet", value = "/user/validate")
@WebServlet(name = "UserValidate", value = "/user/validate")
public class UserValidateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        String username = request.getParameter("username");

        boolean result = userController.validateUsername(username);
        String message;
        if(result) {
            message = "회원가입 가능합니다.";
        } else {
            message = "중복된 아이디입니다.";
        }

        PrintWriter writer = response.getWriter();

        JsonObject object = new JsonObject();
        object.addProperty("status", "success");
        object.addProperty("result", result);
        object.addProperty("message", message);

//        System.out.println(object);

        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
