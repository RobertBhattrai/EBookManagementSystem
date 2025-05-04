package controller;


import dao.OrderCartDAO;
import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.OrderCartModel;
import models.OrderModel;
import models.UserModel;

import java.io.IOException;


@WebServlet(name = "AdminOrderDetailServlet", value = "/AdminOrderDetailServlet")
public class AdminOrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderModel order = OrderDAO.getOrderById(orderId);

            if (order != null) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/WEB-INF/view/admin/orderDetails.jsp").forward(request, response);
            } else {
                response.sendRedirect("/WEB-INF/view/admin/orders.jsp?error=OrderNotFound");
            }
        } catch (Exception e) {
            response.sendRedirect("/WEB-INF/view/admin/orders.jsp?error=InvalidOrderId");
        }
    }
}