package controller;

import dao.OrderDAO;
import dao.OrderCartDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.CartItem;
import models.OrderCartModel;
import models.OrderModel;
import models.UserModel;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("errorMessage", "Your cart is empty");
            response.sendRedirect("ViewCartServlet");
            return;
        }

        // Calculate total price
        double totalPrice = cartItems.stream()
                .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                .sum();

        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            session.setAttribute("errorMessage", "Your cart is empty");
            response.sendRedirect("ViewCartServlet");
            return;
        }

        try {
            // Get form parameters
            String paymentMethod = request.getParameter("paymentMethod");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address1 = request.getParameter("address1");
            String address2 = request.getParameter("address2");
            String landmark = request.getParameter("landmark");
            String city = request.getParameter("city");
            String pincode = request.getParameter("pincode");

            // Get book details from form
            String[] bookIds = request.getParameterValues("bookIds");
            String[] bookNames = request.getParameterValues("bookNames");
            String[] authorNames = request.getParameterValues("authorNames");
            String[] quantities = request.getParameterValues("quantities");
            String[] prices = request.getParameterValues("prices");

            // Calculate total price
            int totalPrice = (int) cartItems.stream()
                    .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                    .sum();

            // Create and save order
            OrderModel order = new OrderModel();
            order.setUserId(user.getId());
            order.setPrice(totalPrice);
            order.setPaymentMethod(paymentMethod);
            order.setStatus("Pending");
            order.setName(name);
            order.setPhone(phone);
            order.setAddress1(address1);
            order.setAddress2(address2);
            order.setLandmark(landmark);
            order.setCity(city);
            order.setPincode(pincode);
            order.setTime(new Timestamp(System.currentTimeMillis()));

            int orderId = OrderDAO.addOrder(order);
            System.out.println("Order created with ID: " + orderId); // Debug log

            if (orderId > 0) {
                // Create OrderCart items
                List<OrderCartModel> orderCartItems = new ArrayList<>();
                for (int i = 0; i < bookIds.length; i++) {
                    OrderCartModel orderCart = new OrderCartModel();
                    orderCart.setOrderId(orderId);
//                    orderCart.setBookId(Integer.parseInt(bookIds[i]));
                    orderCart.setBookName(bookNames[i]);
                    orderCart.setAuthorName(authorNames[i]);
                    orderCart.setQuantity(Integer.parseInt(quantities[i]));
                    orderCart.setPrice(Double.parseDouble(prices[i]));
                    orderCartItems.add(orderCart);
                }

                // Save order cart items
                boolean cartSaved = OrderCartDAO.addOrderCartItems(orderCartItems);
                System.out.println("Cart save result: " + cartSaved);

                if (cartSaved) {
                    // Clear the cart after successful order
                    session.removeAttribute("cart");
                    session.setAttribute("successMessage", "Order placed successfully! Order ID: " + orderId);
                    response.sendRedirect("ViewOrdersServlet");
                } else {
                    session.setAttribute("errorMessage", "Order placed but cart items not saved properly");
                    response.sendRedirect("ViewOrdersServlet");
                }
            } else {
                session.setAttribute("errorMessage", "Failed to place order");
                response.sendRedirect("CheckoutServlet");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing your order: " + e.getMessage());
            response.sendRedirect("CheckoutServlet");
        }
    }
}