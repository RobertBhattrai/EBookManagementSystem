package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;

import java.io.IOException;

@WebServlet(name = "AdminServlet", value = "/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false); // false = don't create new session
        if (session == null || session.getAttribute("loggedIn") == null || !(Boolean) session.getAttribute("loggedIn")) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        // Optional: Check if user is admin
        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            request.getSession().invalidate();
            request.getRequestDispatcher("/WEB-INF/view/unauthorized.jsp").forward(request, response);
            return;
        }

        // Forward to admin dashboard JSP
        request.getRequestDispatcher("/WEB-INF/view/admin/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // for simplicity
    }
}