package controller;

import dao.UserDAO;
import jakarta.servlet.*;
        import jakarta.servlet.http.*;
        import jakarta.servlet.annotation.*;
        import models.UserModel;

import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", value = "/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");

        try {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate passwords match
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("errorMessage", "New password and confirmation do not match");
                response.sendRedirect("ProfileServlet");
                return;
            }

            // Validate password strength
            if (newPassword.length() < 8) {
                session.setAttribute("errorMessage", "Password must be at least 8 characters");
                response.sendRedirect("ProfileServlet");
                return;
            }

            // Update password
            if (UserDAO.updatePassword(user.getId(), currentPassword, newPassword)) {
                session.setAttribute("successMessage", "Password changed successfully");
            } else {
                session.setAttribute("errorMessage", "Failed to change password. Current password may be incorrect.");
            }

            response.sendRedirect("ProfileServlet");

        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error changing password: " + e.getMessage());
            response.sendRedirect("ProfileServlet");
        }
    }
}