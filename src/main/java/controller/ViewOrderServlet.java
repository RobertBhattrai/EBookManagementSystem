package controller;
import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.OrderModel;
import models.UserModel;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "ViewOrdersServlet", value = "/ViewOrdersServlet")
public class ViewOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("LoginServlet");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");

        try {
            List<OrderModel> orders = OrderDAO.getAllOrders().stream()
                    .filter(order -> order.getUserId() == user.getId())
                    .toList();

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/WEB-INF/view/orders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error retrieving orders");
            response.sendRedirect("user");
        }
    }
}