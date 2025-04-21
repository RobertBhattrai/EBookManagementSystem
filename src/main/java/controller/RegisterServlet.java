package controller;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;
import utils.PasswordHash;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("doGet");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch and trim form parameters
        String username = request.getParameter("username") != null ? request.getParameter("username").trim() : null;
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;
        String rawPassword = request.getParameter("password") != null ? request.getParameter("password").trim() : null;
        String confirmPassword = request.getParameter("confirmPassword") != null ? request.getParameter("confirmPassword").trim() : null;
        String firstName = request.getParameter("firstName") != null ? request.getParameter("firstName").trim() : "";
        String lastName = request.getParameter("lastName") != null ? request.getParameter("lastName").trim() : "";
        String name = firstName + " " + lastName;
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : null;
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : null;
        String role = request.getParameter("role") != null ? request.getParameter("role").trim() : null;


        System.out.println("username: " + username);
        System.out.println("email: " + email);
        System.out.println("password: " + rawPassword);
        System.out.println("confirmPassword: " + confirmPassword);
        System.out.println("fullName: " + name);
        System.out.println("phone: " + phone);
        System.out.println("address: " + address);
        System.out.println("role: " + role);


        boolean hasError = false;
        String errorMessage = "";

        // Validate required fields
        if (username == null || username.isEmpty() || email == null || email.isEmpty() || rawPassword == null || rawPassword.isEmpty() || confirmPassword == null || confirmPassword.isEmpty() || role == null || role.isEmpty()) {

            hasError = true;
            errorMessage = "All required fields must be filled out.";
        }

        // Check if passwords match
        if (!hasError && !rawPassword.equals(confirmPassword)) {
            hasError = true;
            errorMessage = "Passwords do not match.";
        }

        // Check if user already exists (optional, if not handled via DB constraints)
        if (!hasError) {
            UserModel existing = UserDAO.getUserByEmailOrUsername(email, username);
            if (existing != null) {
                hasError = true;
                errorMessage = "Email or username already exists.";
            }
        }

        if (hasError) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        // Hash password
        String hashedPassword = PasswordHash.hashPassword(rawPassword);

        // Create and store user
        UserModel newUser = new UserModel(name, email, phone, address, username, hashedPassword, role);
        int userId = UserDAO.addUser(newUser);

        if (userId > 0) {
            request.getSession().setAttribute("registrationSuccess", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        } else {
            request.setAttribute("error", "Registration failed. Username or email may already be in use.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }
}
