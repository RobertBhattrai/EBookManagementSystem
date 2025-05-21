<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.OrderModel" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    List<OrderModel> orders = (List<OrderModel>) request.getAttribute("orders");
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    if (successMessage != null) session.removeAttribute("successMessage");
    if (errorMessage != null) session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - eBook Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #3a56d4;
            --accent: #4895ef;
            --dark: #2b2d42;
            --light: #f8f9fa;
            --text-light: #6c757d;
            --border-radius: 12px;
            --box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            color: var(--dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        .page-header {
            text-align: center;
            margin: 40px 0;
            padding: 0 20px;
        }

        .page-header h1 {
            font-size: 2.5rem;
            margin-bottom: 12px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-header p {
            color: var(--text-light);
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Alerts */
        .alert {
            padding: 16px;
            margin: 0 auto 30px;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            gap: 12px;
            max-width: 800px;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .alert-success {
            background-color: #e6f7ee;
            color: #0a5c36;
            border-left: 4px solid #0a5c36;
        }

        .alert-error {
            background-color: #fde8e8;
            color: #c81e1e;
            border-left: 4px solid #c81e1e;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            max-width: 600px;
            margin: 0 auto;
        }

        .empty-state-icon {
            font-size: 72px;
            color: var(--primary);
            margin-bottom: 20px;
            opacity: 0.8;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 12px;
            color: var(--dark);
        }

        .empty-state p {
            color: var(--text-light);
            margin-bottom: 24px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 24px;
            border-radius: var(--border-radius);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            gap: 8px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: 2px solid var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-light);
            border-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.2);
        }

        /* Orders Container */
        .orders-container {
            max-width: 1000px;
            margin: 0 auto 60px;
        }

        /* Order Card */
        .order-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-bottom: 24px;
            overflow: hidden;
            transition: var(--transition);
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            background: rgba(67, 97, 238, 0.03);
        }

        .order-meta {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .order-id {
            font-weight: 600;
            color: var(--dark);
            font-size: 1.1rem;
        }

        .order-date {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: capitalize;
        }

        .status-processing {
            background-color: #fff8e6;
            color: #e6a700;
        }

        .status-shipped {
            background-color: #e6f2ff;
            color: #0066cc;
        }

        .status-delivered {
            background-color: #e6f7ee;
            color: #0a5c36;
        }

        .status-cancelled {
            background-color: #fde8e8;
            color: #c81e1e;
        }

        .order-body {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding: 20px;
        }

        @media (max-width: 768px) {
            .order-body {
                grid-template-columns: 1fr;
            }
        }

        .order-section {
            margin-bottom: 16px;
        }

        .section-title {
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title i {
            color: var(--primary);
            font-size: 0.9em;
        }

        .order-total {
            text-align: right;
            font-weight: 600;
            font-size: 1.2rem;
            color: var(--dark);
            padding: 20px;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        /* Order Items (if you add them later) */
        .order-items {
            margin-top: 20px;
        }

        .order-item {
            display: flex;
            gap: 16px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 60px;
            height: 80px;
            background: #f5f7fa;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
        }

        .item-details {
            flex: 1;
        }

        .item-title {
            font-weight: 500;
            margin-bottom: 4px;
        }

        .item-author {
            color: var(--text-light);
            font-size: 0.85rem;
            margin-bottom: 6px;
        }

        .item-price {
            font-weight: 500;
            color: var(--dark);
        }

        /* Responsive */
        @media (max-width: 600px) {
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .order-body {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<%@include file="../component/navbar.jsp"%>

<!-- Main Content -->
<div class="container">
    <div class="page-header">
        <h1><i class="fas fa-clipboard-list"></i> Order History</h1>
        <p>View your past purchases and order status</p>
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
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-box-open"></i>
            </div>
            <h3>No Orders Yet</h3>
            <p>You haven't placed any orders with us yet. Start exploring our collection!</p>
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
                <div class="order-meta">
                    <span class="order-id">Order #<%= order.getOrderId() %></span>
                    <span class="order-date">Placed on <%= order.getTime() %></span>
                </div>
                <span class="order-status <%= statusClass %>"><i class="fas fa-circle-notch fa-spin" style="display: none;"></i> <%= order.getStatus() %></span>
            </div>

            <div class="order-body">
                <div>
                    <div class="order-section">
                        <div class="section-title"><i class="fas fa-truck"></i> Shipping Information</div>
                        <div><%= order.getName() %></div>
                        <div><%= order.getAddress1() %></div>
                        <% if (order.getAddress2() != null && !order.getAddress2().isEmpty()) { %>
                        <div><%= order.getAddress2() %></div>
                        <% } %>
                        <div><%= order.getCity() %>, <%= order.getPincode() %></div>
                        <div><%= order.getPhone() %></div>
                    </div>
                </div>

                <div>
                    <div class="order-section">
                        <div class="section-title"><i class="fas fa-credit-card"></i> Payment Method</div>
                        <div><%= order.getPaymentMethod() %></div>
                    </div>

                    <!-- You can add order items here if available -->
                    <!--
                    <div class="order-items">
                        <div class="section-title"><i class="fas fa-book"></i> Items</div>
                        <div class="order-item">
                            <div class="item-image">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="item-details">
                                <div class="item-title">Book Title</div>
                                <div class="item-author">By Author Name</div>
                                <div class="item-price">₹299.00</div>
                            </div>
                        </div>
                    </div>
                    -->
                </div>
            </div>

            <div class="order-total">
                Total: ₹<%= String.format("%.2f", (double) order.getPrice()) %>
            </div>
        </div>
        <% }
        } %>
    </div>
</div>

<script>
    // Add animation to status icons
    document.querySelectorAll('.order-status').forEach(status => {
        if (status.textContent.includes('Processing') || status.textContent.includes('Shipped')) {
            const icon = status.querySelector('i');
            icon.style.display = 'inline-block';
        }
    });
</script>
</body>
</html>