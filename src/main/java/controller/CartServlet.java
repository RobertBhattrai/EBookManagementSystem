package controller;
import dao.BookDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;
import models.CartItem;
import models.UserModel;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CartServlet", value = "/CartServlet")
public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Check if user is logged in
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        // Get book ID from request
        String bookIdParam = request.getParameter("bookId");
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            response.sendRedirect("BrowseBooksServlet");
            return;
        }

        int bookId = Integer.parseInt(bookIdParam);

        // Retrieve or initialize cart
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Fetch the book details
        BookModel book = BookDAO.getBookById(bookId);
        if (book == null) {
            response.sendRedirect("BrowseBooksServlet");
            return;
        }

        // Check if book already exists in cart
        boolean bookExists = false;
        for (CartItem item : cart) {
            if (item.getBook().getBookId() == bookId) {
                item.setQuantity(item.getQuantity() + 1);
                bookExists = true;
                break;
            }
        }

        // Add new item if not already in cart
        if (!bookExists) {
            cart.add(new CartItem(book, 1));
        }

        // Save cart back to session
        session.setAttribute("cart", cart);

        // Redirect to browsing page or cart
        response.sendRedirect("BrowseBooksServlet");
    }
}