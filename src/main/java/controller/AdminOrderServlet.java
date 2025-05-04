package controller;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.OrderModel;
import models.UserModel;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", value = "/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin authentication
        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
        String action = request.getParameter("action");
        String searchTerm = request.getParameter("search");

        List<OrderModel> orders;

        if (searchTerm != null && !searchTerm.isEmpty()) {
            orders = OrderDAO.searchOrders(searchTerm);
        } else {
            orders = OrderDAO.getAllOrders();
        }

        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/WEB-INF/view/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin authentication
        HttpSession session = request.getSession();
        UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String newStatus = request.getParameter("status");

        if (OrderDAO.updateOrderStatus(orderId, newStatus)) {
            session.setAttribute("successMessage", "Order status updated successfully");
        } else {
            session.setAttribute("errorMessage", "Failed to update order status");
        }

        response.sendRedirect("/AdminOrderServlet");
    }
}