<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 5/4/2025
  Time: 5:48 PM
  To change this template use File | Settings | File Templates.--%>

<%@ page import="models.OrderModel" %>
<%@ page import="java.util.List" %>
<%@ page import="models.OrderCartModel" %>
<%@ page import="dao.OrderCartDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");

    if (successMessage != null) session.removeAttribute("successMessage");
    if (errorMessage != null) session.removeAttribute("errorMessage");

    List<OrderCartModel> cartList = OrderCartDAO.getAllOrderCarts();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Management - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .order-card { transition: all 0.3s ease; margin-bottom: 20px; }
        .order-card:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .status-pending { background-color: #e2e3e5; }
        .status-processing { background-color: #fff3cd; }
        .status-completed { background-color: #d1e7dd; }
        .status-cancelled { background-color: #f8d7da; }
        .search-box { margin-bottom: 20px; }
        .action-buttons { white-space: nowrap; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container mt-4">
    <h2 class="mb-4">Order Management</h2>

    <% if (successMessage != null) { %>
    <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i> <%= successMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (errorMessage != null) { %>
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle me-2"></i> <%= errorMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="card search-box">
        <div class="card-body">
            <form action="AdminOrderServlet" method="get">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" placeholder="Search by Order ID, Name, Phone or City">
                    <button class="btn btn-primary" type="submit">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <a href="AdminOrderServlet" class="btn btn-outline-secondary">
                        <i class="fas fa-sync-alt"></i> Reset
                    </a>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>Order ID</th>
                <th>Book Name</th>
                <th>Author Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (cartList != null && orders != null) {
                for (OrderCartModel cart : cartList) {
                    for (OrderModel order : orders) {
                        System.out.println(cart.getOrderId()+" "+order.getOrderId());
                        if (cart.getOrderId() == order.getOrderId()) {
            %>
            <tr>
                <td><%= cart.getOrderId() %></td>
                <td><%= cart.getBookName() %></td>
                <td><%= cart.getAuthorName() %></td>
                <td><%= cart.getQuantity() %></td>
                <td><%= cart.getPrice() %></td>
                <td class="action-buttons">
                    <% if (order.getStatus().equalsIgnoreCase("Pending")) { %>
                    <form action="AdminOrderServlet" method="post" class="d-inline">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <input type="hidden" name="bookId" value="<%= cart.getBookId()%>">
                        <input type="hidden" name="bookName" value="<%= cart.getBookName()%>">
                        <input type="hidden" name="OrderQuantity" value="<%= cart.getQuantity()%>">
                        <input type="hidden" name="status" value="Processing">
                        <button type="submit" class="btn btn-sm btn-success">
                            <i class="fas fa-check"></i> Process
                        </button>
                    </form>
                    <form action="AdminOrderServlet" method="post" class="d-inline ms-1">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <input type="hidden" name="status" value="Cancelled">
                        <button type="submit" class="btn btn-sm btn-danger">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </form>
                    <% } else if (order.getStatus().equalsIgnoreCase("Processing")) { %>
                    <form action="AdminOrderServlet" method="post" class="d-inline">
                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        <input type="hidden" name="bookId" value="<%= cart.getBookId()%>">
                        <input type="hidden" name="bookName" value="<%= cart.getBookName()%>">
                        <input type="hidden" name="status" value="Completed">
                        <input type="hidden" name="currentStatus" value="<%= order.getStatus() %>">
                        <button type="submit" class="btn btn-sm btn-primary">
                            <i class="fas fa-check-circle"></i> Complete
                        </button>
                    </form>
                    <% } %>
                    <a href="AdminOrderDetailServlet?orderId=<%= order.getOrderId() %>" class="btn btn-sm btn-info ms-1">
                        <i class="fas fa-eye"></i> Details
                    </a>
                </td>
            </tr>
            <%       }
            }
            }
            } else { %>
            <tr>
                <td colspan="7" class="text-center text-muted">No orders found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Confirm before cancelling order
    document.querySelectorAll('form[action="AdminOrderServlet"] button[value="Cancelled"]').forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to cancel this order?')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>
