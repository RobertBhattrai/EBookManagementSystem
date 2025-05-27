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
            // Debug: Log cart contents before processing
            System.out.println("Cart contents before checkout:");
            cartItems.forEach(item -> System.out.println(
                    "BookID: " + item.getBook().getBookId() +
                            ", Name: " + item.getBook().getBookName() +
                            ", Qty: " + item.getQuantity()
            ));

            // Get form parameters with validation
            String paymentMethod = validateParameter(request, "paymentMethod", "Payment method");
            String name = validateParameter(request, "name", "Name");
            String phone = validateParameter(request, "phone", "Phone");
            String address1 = validateParameter(request, "address1", "Address line 1");
            String city = validateParameter(request, "city", "City");
            String pincode = validateParameter(request, "pincode", "Pincode");

            String address2 = request.getParameter("address2");
            String landmark = request.getParameter("landmark");

            // Get book details from form
            String[] bookIds = request.getParameterValues("bookIds");
            String[] bookNames = request.getParameterValues("bookNames");
            String[] authorNames = request.getParameterValues("authorNames");
            String[] quantities = request.getParameterValues("quantities");
            String[] prices = request.getParameterValues("prices");

            // Debug: Log received parameters
            System.out.println("Received parameters:");
            System.out.println("bookIds count: " + (bookIds != null ? bookIds.length : 0));
            if (bookIds != null) {
                for (int i = 0; i < bookIds.length; i++) {
                    System.out.printf("Item %d: BookID=%s, Name=%s, Qty=%s, Price=%s%n",
                            i, bookIds[i], bookNames[i], quantities[i], prices[i]);
                }
            }

            // Validate book details
            if (bookIds == null || bookNames == null || authorNames == null ||
                    quantities == null || prices == null) {
                throw new ServletException("Missing book details in the request");
            }

            if (!(bookIds.length == bookNames.length &&
                    bookNames.length == authorNames.length &&
                    authorNames.length == quantities.length &&
                    quantities.length == prices.length)) {
                throw new ServletException("Mismatched book details in the request");
            }

            // Verify no null/empty book IDs
            for (int i = 0; i < bookIds.length; i++) {
                if (bookIds[i] == null || bookIds[i].trim().isEmpty()) {
                    throw new ServletException("Empty book ID found at position " + i);
                }
                try {
                    Integer.parseInt(bookIds[i]); // Verify it's a valid number
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid book ID format at position " + i + ": " + bookIds[i]);
                }
            }

            // Calculate total price from cart items (more reliable than form parameters)
            int totalPrice = (int) cartItems.stream()
                    .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                    .sum();

            System.out.println(user.getId()+ totalPrice+paymentMethod+name+phone+address1+city+pincode+address2+landmark+city+pincode);

            // Create and save order
            OrderModel order = new OrderModel();
            order.setUserId(user.getId());
            order.setPrice(totalPrice);
            order.setPaymentMethod(paymentMethod);
            order.setStatus("Pending");
            order.setName(name);
            order.setPhone(phone);
            order.setAddress1(address1);
            order.setAddress2(address2 != null ? address2 : "");
            order.setLandmark(landmark != null ? landmark : "");
            order.setCity(city);
            order.setPincode(pincode);
            order.setTime(new Timestamp(System.currentTimeMillis()));


            int orderId = OrderDAO.addOrder(order);
            System.out.println("Order created with ID: " + orderId);

            if (orderId <= 0) {
                throw new ServletException("Failed to create order in database");
            }

            // Create OrderCart items with additional validation
            List<OrderCartModel> orderCartItems = new ArrayList<>();
            for (int i = 0; i < bookIds.length; i++) {
                try {
                    OrderCartModel orderCart = new OrderCartModel();
                    orderCart.setOrderId(orderId);

                    int bookId = Integer.parseInt(bookIds[i]);
                    if (bookId <= 0) {
                        throw new ServletException("Invalid book ID: " + bookIds[i]);
                    }
                    orderCart.setBookId(bookId);

                    orderCart.setBookName(bookNames[i]);
                    orderCart.setAuthorName(authorNames[i]);

                    int quantity = Integer.parseInt(quantities[i]);
                    if (quantity <= 0) {
                        throw new ServletException("Invalid quantity: " + quantities[i]);
                    }
                    orderCart.setQuantity(quantity);

                    double price = Double.parseDouble(prices[i]);
                    if (price <= 0) {
                        throw new ServletException("Invalid price: " + prices[i]);
                    }
                    orderCart.setPrice(price);

                    orderCartItems.add(orderCart);
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid numeric value in book details at index " + i, e);
                }
            }

            // Debug: Print all order cart items before saving
            System.out.println("Order cart items to be saved:");
            for (OrderCartModel item : orderCartItems) {
                System.out.println("OrderID: " + item.getOrderId() +
                        ", BookID: " + item.getBookId() +
                        ", Name: " + item.getBookName() +
                        ", Qty: " + item.getQuantity() +
                        ", Price: " + item.getPrice());
            }

            // Save order cart items
            boolean cartSaved = OrderCartDAO.addOrderCartItems(orderCartItems);
            System.out.println("Cart save result: " + cartSaved);

            if (!cartSaved) {
                // Consider adding transaction rollback here if possible
                throw new ServletException("Failed to save order items");
            }

            // Clear the cart after successful order
            session.removeAttribute("cart");
            session.setAttribute("successMessage", "Order placed successfully! Order ID: " + orderId);
            response.sendRedirect("ViewOrdersServlet");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error processing your order: " +
                    (e.getMessage() != null ? e.getMessage() : "Please try again later"));
            response.sendRedirect("CheckoutServlet");
        }
    }

    private String validateParameter(HttpServletRequest request, String paramName, String fieldName)
            throws ServletException {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            throw new ServletException(fieldName + " is required");
        }
        return value.trim();
    }
}