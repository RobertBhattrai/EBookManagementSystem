package controller;

import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;
import models.UserModel;

import java.io.File;
import java.io.IOException;

@WebServlet(name = "AddBookServlet", value = "/AddBookServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 1024 * 1024 * 10,     // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class AddBookServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Forward to addbook.jsp
        request.getRequestDispatcher("/WEB-INF/view/addBook.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String bookName = request.getParameter("bookName");
        String authorName = request.getParameter("authorName");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("bookCategory");
        String available = request.getParameter("available");
        Part filePart = request.getPart("photo");

        // Validate parameters
        if (bookName == null || bookName.trim().isEmpty() ||
                authorName == null || authorName.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                available == null || available.trim().isEmpty() ||
                filePart == null || filePart.getSize() == 0) {

            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/view/addBook.jsp").forward(request, response);
            return;
        }

        // Parse numeric values
        double price;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format");
            request.getRequestDispatcher("/WEB-INF/view/addBook.jsp").forward(request, response);
            return;
        }

        // Handle file upload
        String fileName = null;
        try {
            // Get filename and create upload directory if needed
            fileName = getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save file
            filePart.write(uploadPath + File.separator + fileName);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "File upload failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/addBook.jsp").forward(request, response);
            return;
        }

        // Create BookModel and save to database
        BookModel book = new BookModel();
        book.setBookName(bookName);
        book.setAuthor(authorName);
        book.setPrice(price);
        book.setCategory(category);
        book.setStatus(available);
        book.setPhoto(fileName);

        try {
            int bookId = BookDAO.addBook(book);
            if (bookId > 0) {
                response.sendRedirect(request.getContextPath() + "/ViewAllBook");
            } else {
                // Clean up uploaded file if database operation failed
                if (fileName != null) {
                    new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + fileName).delete();
                }
                request.setAttribute("errorMessage", "Failed to add book to database");
                request.getRequestDispatcher("/addBook.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Clean up uploaded file if any error occurred
            if (fileName != null) {
                new File(getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + fileName).delete();
            }
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/addBook.jsp").forward(request, response);
        }
    }

    // Helper method to extract filename from Part
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}