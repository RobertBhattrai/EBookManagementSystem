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
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Optional: Check if user is admin
        UserModel user = (UserModel) session.getAttribute("user");
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
            return;
        }

        // Forward to admin dashboard JSP
        request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // for simplicity
    }
}