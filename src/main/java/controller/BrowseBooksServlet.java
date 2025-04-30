package controller;
import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;
import models.UserModel;

import java.io.IOException;
import java.util.List;

@WebServlet("/BrowseBooksServlet")
public class BrowseBooksServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check authentication
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        try {
            String searchQuery = request.getParameter("search");

            // Get books from DAO (with optional search filter)
            List<BookModel> books;
            if (searchQuery != null && !searchQuery.isEmpty()) {
                books = BookDAO.searchBooks(searchQuery);
            } else {
                books = BookDAO.getAllBooks();
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("/WEB-INF/view/browseBook.jsp").forward(request, response);

        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error loading books: " + e.getMessage());
            response.sendRedirect("/WEB-INF/view/home.jsp");
        }
    }
}