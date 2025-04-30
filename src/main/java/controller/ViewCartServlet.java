package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;
import models.CartItem;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "ViewCartServlet", value = "/ViewCartServlet")
public class ViewCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("cartEmpty", true);
        } else {
            request.setAttribute("cart", cart);
            // Calculate total price
            double total = cart.stream()
                    .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                    .sum();
            request.setAttribute("totalPrice", total);
        }

        request.getRequestDispatcher("/WEB-INF/view/viewCart.jsp").forward(request, response);
    }
}