package controller;

import dao.BookDAO;
import dao.OrderCartDAO;
import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.BookModel;
import models.OrderCartModel;
import models.OrderModel;
import models.UserModel;

import java.io.IOException;
import java.util.List;

import static java.lang.Integer.parseInt;

@WebServlet(name = "AdminOrderServlet", value = "/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String action = request.getParameter("action");
        String searchTerm = request.getParameter("search");
        String filterStatus = request.getParameter("filterStatus");

        List<OrderModel> orders;

        if (searchTerm != null && !searchTerm.isEmpty()) {
            orders = OrderDAO.searchOrders(searchTerm);
        } else if (filterStatus != null && !filterStatus.isEmpty()) {
            orders = OrderDAO.getOrdersByStatus(filterStatus);
        } else {
            orders = OrderDAO.getAllOrders();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/view/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        int orderId = parseInt(request.getParameter("orderId"));
        String bookName = request.getParameter("bookName");
        System.out.println(bookName);
        System.out.println(orderId);
        BookModel book = BookDAO.getBookByName(bookName);
        System.out.println(book);
        assert book != null;
        String TotalQuantity = book.getStatus();
        int bookId = book.getBookId();
        String OrderQuantity = request.getParameter("OrderQuantity");
        String newStatus = request.getParameter("status");
        String currentStatus = request.getParameter("currentStatus"); // Add this hidden field in your form
        System.out.println(orderId+newStatus+currentStatus+TotalQuantity+OrderQuantity);
        try {
            // First update the order status
            boolean statusUpdated = OrderDAO.updateOrderStatus(orderId, newStatus);
            System.out.println(statusUpdated);
            System.out.println("Debugging");
            if (statusUpdated) {
                // If changing from Pending to Processing, update book quantities
                if (newStatus.equals("Processing")) {
                    // Get all cart items for this order
                    List<OrderCartModel> cartItems = OrderCartDAO.getCartsByOrderId(orderId);
                    System.out.println(cartItems);
                    boolean allQuantitiesUpdated = true;

                    int TotalQnt = parseInt(TotalQuantity);
                    int OrderQnt = parseInt(OrderQuantity);
                    int quantityChange = TotalQnt - OrderQnt;
                    System.out.println(quantityChange);
                    String qnt = Integer.toString(quantityChange);
                    boolean success = BookDAO.updateBookQuantities(bookId, qnt);

                    if (!success) {
                        allQuantitiesUpdated = false;
                        System.err.println("Failed to update quantity for book ID: " + bookId);
                    }

                    if (allQuantitiesUpdated) {
                        session.setAttribute("successMessage",
                                "Order status updated to Processing and book quantities adjusted");
                    } else {
                        session.setAttribute("warningMessage",
                                "Order status updated but some book quantities couldn't be adjusted");
                    }
                }
                else {
                    session.setAttribute("successMessage", "Order status updated successfully");
                }
            } else {
                session.setAttribute("errorMessage", "Failed to update order status");
            }

        } catch (Exception e) {
            session.setAttribute("errorMessage",
                    "Error processing order update: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/AdminOrderDetailServlet?orderId=" + orderId);
    }
}