package controller;

import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;

import java.io.IOException;

@WebServlet(name = "DeleteBookServlet", value = "/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            BookModel book = BookDAO.getBookById(bookId);

            if (book != null) {
                // Delete the photo file if exists
                if (book.getPhoto() != null && !book.getPhoto().isEmpty()) {
                    java.nio.file.Path photoPath = java.nio.file.Paths.get(
                            getServletContext().getRealPath("") + "uploads" + java.io.File.separator + book.getPhoto());
                    java.nio.file.Files.deleteIfExists(photoPath);
                }

                boolean success = BookDAO.deleteBook(bookId);

                if (success) {
                    request.getSession().setAttribute("successMessage", "Book deleted successfully");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to delete book");
                }
            } else {
                request.getSession().setAttribute("errorMessage", "Book not found");
            }

            response.sendRedirect(request.getContextPath() + "/ViewAllBook");

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid book ID");
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error deleting book: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        }
    }
}