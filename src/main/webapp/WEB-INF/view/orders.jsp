<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 5/4/2025
  Time: 10:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.OrderModel" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    // Clear messages after displaying
    if (successMessage != null) session.removeAttribute("successMessage");
    if (errorMessage != null) session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - eBook Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* (Include all the CSS styles from previous pages) */

        .orders-container {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .order-card {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: box-shadow 0.3s ease;
        }

        .order-card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .order-id {
            font-weight: bold;
            color: var(--dark-color);
        }

        .order-date {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .order-status {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-processing {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-shipped {
            background-color: #cce5ff;
            color: #004085;
        }

        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .order-details {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .shipping-info {
            margin-bottom: 1rem;
        }

        .shipping-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .order-total {
            font-weight: bold;
            font-size: 1.2rem;
            text-align: right;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
        }

        @media (max-width: 768px) {
            .order-details {
                grid-template-columns: 1fr;
            }

            .order-header {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<!-- (Same as other pages) -->

<!-- Main Content -->
<div class="container">
    <div class="page-header">
        <h1><i class="fas fa-history"></i> My Orders</h1>
        <p>View your order history and status</p>
    </div>

    <% if (successMessage != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> <%= successMessage %>
    </div>
    <% } %>

    <% if (errorMessage != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
    </div>
    <% } %>

    <div class="orders-container">
        <% if (orders == null || orders.isEmpty()) { %>
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-box-open"></i>
            </div>
            <h3>No orders found</h3>
            <p class="empty-cart-message">You haven't placed any orders yet.</p>
            <a href="BrowseBooksServlet" class="btn btn-primary">
                <i class="fas fa-book-open"></i> Browse Books
            </a>
        </div>
        <% } else {
            for (OrderModel order : orders) {
                String statusClass = "";
                switch(order.getStatus().toLowerCase()) {
                    case "processing": statusClass = "status-processing"; break;
                    case "shipped": statusClass = "status-shipped"; break;
                    case "delivered": statusClass = "status-delivered"; break;
                    case "cancelled": statusClass = "status-cancelled"; break;
                    default: statusClass = "status-processing";
                }
        %>
        <div class="order-card">
            <div class="order-header">
                <div>
                    <span class="order-id">Order #<%= order.getOrderId() %></span>
                    <span class="order-date">Placed on <%= order.getTime() %></span>
                </div>
                <span class="order-status <%= statusClass %>"><%= order.getStatus() %></span>
            </div>

            <div class="order-details">
                <div>
                    <div class="shipping-info">
                        <div class="shipping-title">Shipping Address</div>
                        <div><%= order.getName() %></div>
                        <div><%= order.getAddress1() %></div>
                        <% if (order.getAddress2() != null && !order.getAddress2().isEmpty()) { %>
                        <div><%= order.getAddress2() %></div>
                        <% } %>
                        <div><%= order.getCity() %>, <%= order.getPincode() %></div>
                        <div>Phone: <%= order.getPhone() %></div>
                    </div>

                    <div class="payment-info">
                        <div class="shipping-title">Payment Method</div>
                        <div><%= order.getPaymentMethod() %></div>
                    </div>
                </div>

                <div class="order-total">
                    Total: ₹<%= String.format("%.2f", (double) order.getPrice()) %>
                </div>
            </div>
        </div>
        <% }
        } %>
    </div>
</div>
</body>
</html>
