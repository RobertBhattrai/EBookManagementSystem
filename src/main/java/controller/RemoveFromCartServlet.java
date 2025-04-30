package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.CartItem;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RemoveFromCartServlet", value = "/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart != null) {
                cart.removeIf(item -> item.getBook().getBookId() == bookId);
                session.setAttribute("cart", cart);
            }

            response.sendRedirect("ViewCartServlet");

        } catch (NumberFormatException e) {
            response.sendRedirect("ViewCartServlet");
        }
    }
}