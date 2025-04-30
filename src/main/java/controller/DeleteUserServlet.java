package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;

import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", value = "/DeleteUserServlet")

public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin authentication
        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        try {
            // Get user ID to delete
            int userId = Integer.parseInt(request.getParameter("id"));

            // Prevent admin from deleting themselves
            if (userId == loggedInUser.getId()) {
                session.setAttribute("errorMessage", "You cannot delete your own admin account");
                response.sendRedirect(request.getContextPath() + "/ViewUserServlet");
                return;
            }

            // Delete user from database
            boolean deleted = UserDAO.deleteUser(userId);

            if (deleted) {
                session.setAttribute("successMessage", "User deleted successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to delete user");
            }

            response.sendRedirect(request.getContextPath() + "/ViewUserServlet");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid user ID format");
            response.sendRedirect(request.getContextPath() + "/ViewUserServlet");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error deleting user: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewUserServlet");
        }
    }
}