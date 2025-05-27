<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 5/4/2025
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.OrderModel" %>
<jsp:useBean id="order" class="models.OrderModel" scope="request" />
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;}
        table { border-collapse: collapse; width: 70%; margin: auto; }
        td, th { border: 1px solid #ddd; padding: 12px; }
        th { background-color: #f2f2f2; }
        h2 { text-align: center; }
        .btn-back { margin: 20px auto; display: block; text-align: center; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<h2>Order Details - ID #${order.orderId}</h2>

<table>
    <tr><th>Order ID</th><td>${order.orderId}</td></tr>
    <tr><th>User ID</th><td>${order.userId}</td></tr>
    <tr><th>Timestamp</th><td>${order.time}</td></tr>
    <tr><th>Price</th><td>Rs. ${order.price}</td></tr>
    <tr><th>Payment Method</th><td>${order.paymentMethod}</td></tr>
    <tr><th>Status</th><td>${order.status}</td></tr>

    <tr><th>Customer Name</th><td>${order.name}</td></tr>
    <tr><th>Phone</th><td>${order.phone}</td></tr>
    <tr><th>Address Line 1</th><td>${order.address1}</td></tr>
    <tr><th>Address Line 2</th><td>${order.address2}</td></tr>
    <tr><th>Landmark</th><td>${order.landmark}</td></tr>
    <tr><th>City</th><td>${order.city}</td></tr>
    <tr><th>Pincode</th><td>${order.pincode}</td></tr>
</table>

<div class="btn-back">
    <a href="${pageContext.request.contextPath}/AdminOrderServlet">← Back to Orders</a>
</div>
</body>
</html>
