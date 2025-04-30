package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;
import dao.UserDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewUserServlet", value = "/ViewUserServlet")
public class ViewUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        try {
            System.out.println("Before getting users");
            List<UserModel> users = UserDAO.getAllUsers();
            System.out.println("Users retrieved: " + users.size());

            request.setAttribute("users", users);

            System.out.println("Before forward");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/viewUsers.jsp");
            dispatcher.forward(request, response);
            System.out.println("After forward - this shouldn't print if forward works");

        } catch (Exception e) {
            System.err.println("Error in ViewUserServlet: ");
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error retrieving users: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
}