package controller;
import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;

import java.io.IOException;

@WebServlet(name = "BookDetailsServlet", value = "/BookDetailsServlet")

public class BookDetailsServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get book ID from request parameter
            String bookIdStr = request.getParameter("id");
            if (bookIdStr == null || bookIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/BrowseBooksServlet");
                return;
            }

            int bookId = Integer.parseInt(bookIdStr);

            // Fetch book details from service
            BookModel book = BookDAO.getBookById(bookId);

            if (book == null) {
                request.setAttribute("errorMessage", "Book not found");
                request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
                return;
            }

            // Set book as request attribute and forward to JSP
            request.setAttribute("book", book);
            request.getRequestDispatcher("/WEB-INF/view/bookDetails.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid book ID");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching book details");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
}