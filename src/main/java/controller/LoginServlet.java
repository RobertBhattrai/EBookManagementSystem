package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.UserModel;

import java.io.IOException;
import java.util.Base64;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMe";
    private static final int COOKIE_AGE = 7 * 24 * 60 * 60; // 7 days

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is already logged in via remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (REMEMBER_ME_COOKIE_NAME.equals(cookie.getName())) {
                    String[] credentials = decodeCookieValue(cookie.getValue());
                    if (credentials != null && credentials.length == 2) {
                        String username = credentials[0];
                        String password = credentials[1];
                        UserModel user = UserDAO.getUserByEmailOrUsername(username, password);

                        if (user != null) {
                            // Auto-login successful
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);
                            session.setAttribute("loggedIn", true);

                            // Redirect based on role
                            String role = user.getRole(); // Ensure this method exists in UserModel
                            if ("admin".equalsIgnoreCase(role)) {
                                response.sendRedirect(request.getContextPath() + "/Admin-Dashboard");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/User-Dashboard");
                            }
                            return;
                        }
                    }
                }
            }
        }

        // Check for registration success message
        String registrationSuccess = (String) request.getSession().getAttribute("registrationSuccess");
        if (registrationSuccess != null) {
            request.setAttribute("registrationSuccess", registrationSuccess);
            request.getSession().removeAttribute("registrationSuccess");
        }

        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        System.out.println(password);
        System.out.println(username);

        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        UserModel user = UserDAO.getUserByEmailOrUsername(username, password);

        System.out.println(user);

        if (user != null) {
            // Login success: create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("loggedIn", true);

            // Handle Remember Me
            if ("on".equals(rememberMe)) {
                String encoded = encodeCookieValue(username, password);
                Cookie rememberMeCookie = new Cookie(REMEMBER_ME_COOKIE_NAME, encoded);
                rememberMeCookie.setMaxAge(COOKIE_AGE);
                rememberMeCookie.setPath("/");
                response.addCookie(rememberMeCookie);
            }

            // Redirect based on role
            String role = user.getRole(); // Ensure this method exists in UserModel
            if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(request.getContextPath() + "/user");
            }

        } else {
            // Login failed
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    // Encode cookie value using Base64
    private String encodeCookieValue(String username, String password) {
        String combined = username + ":" + password;
        return Base64.getEncoder().encodeToString(combined.getBytes());
    }

    // Decode cookie value from Base64
    private String[] decodeCookieValue(String cookieValue) {
        try {
            String decoded = new String(Base64.getDecoder().decode(cookieValue));
            return decoded.split(":");
        } catch (Exception e) {
            return null;
        }
    }
}
