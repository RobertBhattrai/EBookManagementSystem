package controller;

import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewAllBook", value = "/ViewAllBook")
public class ViewBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // Get all books from DAO
            List<BookModel> books = BookDAO.getAllBooks();

            // Set books in request attribute
            request.setAttribute("books", books);

            // Forward to view page
            request.getRequestDispatcher("/WEB-INF/view/viewAllBook.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle errors
            request.setAttribute("errorMessage", "Error retrieving books: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}