package controller;

import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;

import java.io.IOException;

@WebServlet(name = "EditBookServlet", value = "/EditBookServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 1024 * 1024 * 10,     // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class EditBookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("id"));
            BookModel book = BookDAO.getBookById(bookId);

            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("/WEB-INF/view/editBook.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("errorMessage", "Book not found");
                response.sendRedirect(request.getContextPath() + "/ViewAllBook");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid book ID");
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error retrieving book: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String bookName = request.getParameter("bookName");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String available = request.getParameter("available");
            Part filePart = request.getPart("photo");

            BookModel existingBook = BookDAO.getBookById(bookId);
            if (existingBook == null) {
                request.getSession().setAttribute("errorMessage", "Book not found");
                response.sendRedirect(request.getContextPath() + "/ViewAllBook");
                return;
            }

            // If new photo is uploaded, use it; otherwise keep existing photo
            String photo = existingBook.getPhoto();
            if (filePart != null && filePart.getSize() > 0) {
                // Delete old photo file
                if (photo != null && !photo.isEmpty()) {
                    java.nio.file.Path oldPhotoPath = java.nio.file.Paths.get(
                            getServletContext().getRealPath("") + "uploads" + java.io.File.separator + photo);
                    java.nio.file.Files.deleteIfExists(oldPhotoPath);
                }

                // Save new photo
                String fileName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + java.io.File.separator + fileName);
                photo = fileName;
            }

            BookModel updatedBook = new BookModel();
            updatedBook.setBookId(bookId);
            updatedBook.setBookName(bookName);
            updatedBook.setAuthor(author);
            updatedBook.setPrice(price);
            updatedBook.setCategory(category);
            updatedBook.setStatus(available);
            updatedBook.setPhoto(photo);

            boolean success = BookDAO.updateBook(updatedBook);

            if (success) {
                request.getSession().setAttribute("successMessage", "Book updated successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update book");
            }

            response.sendRedirect(request.getContextPath() + "/ViewAllBook");

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid input format");
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error updating book: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ViewAllBook");
        }
    }
}