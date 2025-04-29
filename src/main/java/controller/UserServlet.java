package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;

import java.io.IOException;

@WebServlet(name = "UserServlet", value = "/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null || !(Boolean) session.getAttribute("loggedIn")) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Role check
        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        if (user == null || !"user".equalsIgnoreCase(user.getRole())) {
            request.getSession().invalidate();
            request.getRequestDispatcher("/WEB-INF/view/unauthorized.jsp").forward(request, response);
            return;
        }

        // Forward to user dashboard JSP
        request.getRequestDispatcher("/WEB-INF/view/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}