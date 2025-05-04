package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;
import dao.UserDAO;

import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        // Get current user from session
        UserModel user = (UserModel) session.getAttribute("loggedInUser");

        // Forward to profile page with user data
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        UserModel currentUser = (UserModel) session.getAttribute("loggedInUser");

        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String username = request.getParameter("username");

            // Create updated user object
            UserModel updatedUser = new UserModel();
            updatedUser.setId(currentUser.getId());
            updatedUser.setName(name);
            updatedUser.setEmail(email);
            updatedUser.setPhone(phone);
            updatedUser.setAddress(address);
            updatedUser.setUsername(username);
            updatedUser.setPassword(currentUser.getPassword()); // Keep existing password
            updatedUser.setRole(currentUser.getRole()); // Keep existing role

            // Update user in database
            if (UserDAO.updateUser(updatedUser)) {
                // Update session with new user data
                session.setAttribute("loggedInUser", updatedUser);
                session.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to update profile");
            }

            response.sendRedirect("ProfileServlet");

        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error updating profile: " + e.getMessage());
            response.sendRedirect("ProfileServlet");
        }
    }
}