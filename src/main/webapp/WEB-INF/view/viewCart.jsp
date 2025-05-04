<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 8:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartItem" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    boolean cartEmpty = cartItems == null || cartItems.isEmpty();
    double totalPrice = 0.0;

    if (!cartEmpty) {
        totalPrice = cartItems.stream()
                .mapToDouble(item -> item.getBook().getPrice() * item.getQuantity())
                .sum();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - eBook Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --accent-color: #e74c3c;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
        }

        /* Navigation Bar */
        .navbar {
            background-color: var(--dark-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .brand {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
        }

        .brand-logo {
            font-size: 1.8rem;
            margin-right: 0.8rem;
            color: var(--primary-color);
        }

        .brand-text {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-item {
            margin-left: 1.5rem;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            padding: 0.5rem 0;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
            position: relative;
        }

        .nav-link:hover {
            color: var(--primary-color);
        }

        .nav-link i {
            margin-right: 0.5rem;
            font-size: 1.1rem;
        }

        .cart-count {
            background-color: var(--accent-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            position: absolute;
            top: -5px;
            right: -10px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            color: white;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
            animation: fadeIn 0.5s ease;
        }

        .page-header h1 {
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            font-size: 2.2rem;
        }

        .page-header p {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .cart-container {
            background: white;
            border-radius: 8px;
            box-shadow: var(--shadow);
            padding: 2rem;
            animation: slideUp 0.5s ease;
        }

        /* Cart Table */
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        .cart-table th {
            text-align: left;
            padding: 1rem;
            background-color: var(--light-color);
            border-bottom: 2px solid #ddd;
            font-weight: 600;
            color: var(--dark-color);
        }

        .cart-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .cart-item-image {
            width: 80px;
            height: 100px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: var(--shadow);
            transition: transform 0.3s ease;
        }

        .cart-item-image:hover {
            transform: scale(1.05);
        }

        .cart-item-title {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.3rem;
        }

        .cart-item-author {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        /* Quantity Controls */
        .quantity-control {
            display: flex;
            align-items: center;
        }

        .quantity-btn {
            width: 30px;
            height: 30px;
            background-color: var(--light-color);
            border: 1px solid #ddd;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            font-weight: bold;
        }

        .quantity-btn:hover {
            background-color: #e0e0e0;
        }

        .quantity-btn:active {
            transform: scale(0.95);
        }

        .quantity-input {
            width: 50px;
            text-align: center;
            margin: 0 5px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-weight: 500;
        }

        /* Action Buttons */
        .action-btns {
            display: flex;
            gap: 10px;
        }

        .update-btn, .remove-btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .update-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .update-btn:hover {
            background-color: #2980b9;
        }

        .remove-btn {
            background-color: var(--accent-color);
            color: white;
        }

        .remove-btn:hover {
            background-color: #c0392b;
        }

        .remove-btn i {
            margin-right: 5px;
        }

        /* Cart Summary */
        .cart-summary {
            display: flex;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        .summary-card {
            background: var(--light-color);
            padding: 1.5rem;
            border-radius: 8px;
            width: 300px;
            box-shadow: var(--shadow);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px dashed #ddd;
        }

        .summary-total {
            font-weight: bold;
            font-size: 1.2rem;
            border-top: 2px solid var(--dark-color);
            padding-top: 1rem;
            margin-top: 1rem;
        }

        /* Checkout Button */
        .checkout-btn {
            width: 100%;
            padding: 1rem;
            background-color: var(--secondary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }

        .checkout-btn:hover {
            background-color: #27ae60;
        }

        .checkout-btn i {
            margin-right: 10px;
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 3rem;
            animation: fadeIn 0.5s ease;
        }

        .empty-cart-icon {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .empty-cart-message {
            font-size: 1.2rem;
            color: #7f8c8d;
            margin-bottom: 1.5rem;
        }

        /* Buttons */
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                padding: 1rem;
            }

            .nav-links {
                margin-top: 1rem;
                width: 100%;
                justify-content: space-around;
            }

            .nav-item {
                margin-left: 0;
            }

            .cart-table {
                display: block;
                overflow-x: auto;
            }

            .cart-table td {
                min-width: 120px;
            }

            .summary-card {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .quantity-control {
                flex-direction: column;
                gap: 5px;
            }

            .quantity-input {
                margin: 5px 0;
            }

            .action-btns {
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/user" class="brand">
        <span class="brand-logo"><i class="fas fa-book-reader"></i></span>
        <span class="brand-text">eBook Store</span>
    </a>

    <ul class="nav-links">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/user" class="nav-link">
                <i class="fas fa-home"></i> Home
            </a>
        </li>
        <li class="nav-item">
            <a href="BrowseBooksServlet" class="nav-link">
                <i class="fas fa-book-open"></i> Browse Books
            </a>
        </li>
        <li class="nav-item">
            <a href="ViewCartServlet" class="nav-link">
                <i class="fas fa-shopping-cart"></i> Cart
                <% if (!cartEmpty) { %>
                <span class="cart-count"><%= cartItems.size() %></span>
                <% } %>
            </a>
        </li>
        <li class="nav-item">
            <a href="ViewOrdersServlet" class="nav-link">
                <i class="fas fa-history"></i> My Orders
            </a>
        </li>
    </ul>

    <div class="user-profile">
        <% if (loggedInUser != null) { %>
        <span><i class="fas fa-user"></i> <%= loggedInUser.getName() %></span>
        <a href="LogoutServlet" class="nav-link" style="margin-left: 1rem;">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
        <% } %>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="page-header">
        <h1><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h1>
        <p>Review and manage your selected books</p>
    </div>

    <div class="cart-container">
        <% if (cartEmpty) { %>
        <div class="empty-cart">
            <div class="empty-cart-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <h3>Your cart is empty</h3>
            <p class="empty-cart-message">You haven't added any books to your cart yet.</p>
            <a href="BrowseBooksServlet" class="btn btn-primary">
                <i class="fas fa-book-open"></i> Browse Books
            </a>
        </div>
        <% } else { %>
        <form id="cartForm" action="UpdateCartServlet" method="post">
            <table class="cart-table">
                <thead>
                <tr>
                    <th>Book</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% for (CartItem item : cartItems) { %>
                <tr>
                    <td>
                        <div style="display: flex; align-items: center;">
                            <% if (item.getBook().getPhoto() != null && !item.getBook().getPhoto().isEmpty()) { %>
                            <img src="uploads/<%= item.getBook().getPhoto() %>" alt="<%= item.getBook().getBookName() %>" class="cart-item-image">
                            <% } else { %>
                            <div style="width: 80px; height: 100px; background-color: #eee; display: flex; align-items: center; justify-content: center; border-radius: 4px;">
                                <i class="fas fa-book" style="font-size: 2rem; color: #999;"></i>
                            </div>
                            <% } %>
                            <div style="margin-left: 1rem;">
                                <div class="cart-item-title"><%= item.getBook().getBookName() %></div>
                                <div class="cart-item-author">By <%= item.getBook().getAuthor() %></div>
                            </div>
                        </div>
                    </td>
                    <td>₹<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                    <td>
                        <div class="quantity-control">
                            <button type="button" class="quantity-btn minus" data-book-id="<%= item.getBook().getBookId() %>">-</button>
                            <input type="number" name="quantity_<%= item.getBook().getBookId() %>"
                                   value="<%= item.getQuantity() %>" min="1" max="10" class="quantity-input">
                            <button type="button" class="quantity-btn plus" data-book-id="<%= item.getBook().getBookId() %>">+</button>
                        </div>
                    </td>
                    <td>₹<%= String.format("%.2f", item.getBook().getPrice() * item.getQuantity()) %></td>
                    <td>
                        <div class="action-btns">
                            <button type="submit" name="update" value="<%= item.getBook().getBookId() %>" class="update-btn">
                                <i class="fas fa-sync-alt"></i> Update
                            </button>
                            <button type="submit" formaction="RemoveFromCartServlet" name="bookId" value="<%= item.getBook().getBookId() %>" class="remove-btn">
                                <i class="fas fa-trash-alt"></i> Remove
                            </button>
                        </div>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <div class="cart-summary">
                <div class="summary-card">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>₹<%= String.format("%.2f", totalPrice) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span>FREE</span>
                    </div>
                    <div class="summary-row summary-total">
                        <span>Total:</span>
                        <span>₹<%= String.format("%.2f", totalPrice) %></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/CheckoutServlet" class="checkout-btn">
                        <i class="fas fa-credit-card"></i> Proceed to Checkout
                    </a>
                </div>
            </div>
        </form>
        <% } %>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Handle plus/minus buttons
        document.querySelectorAll('.quantity-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const bookId = this.getAttribute('data-book-id');
                const input = document.querySelector(`input[name="quantity_${bookId}"]`);
                let value = parseInt(input.value);

                if (this.classList.contains('minus') && value > 1) {
                    input.value = value - 1;
                } else if (this.classList.contains('plus') && value < 10) {
                    input.value = value + 1;
                }

                // Highlight the update button
                const updateBtn = document.querySelector(`button[name="update"][value="${bookId}"]`);
                updateBtn.style.backgroundColor = '#f39c12';
                updateBtn.innerHTML = '<i class="fas fa-sync-alt"></i> Update Needed';
            });
        });

        // Auto-update when quantity changes (optional)
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function() {
                const bookId = this.name.split('_')[1];
                const updateBtn = document.querySelector(`button[name="update"][value="${bookId}"]`);
                updateBtn.style.backgroundColor = '#f39c12';
                updateBtn.innerHTML = '<i class="fas fa-sync-alt"></i> Update Needed';
            });
        });

        // Highlight all update buttons when form is submitted
        document.getElementById('cartForm').addEventListener('submit', function() {
            document.querySelectorAll('.update-btn').forEach(btn => {
                btn.style.backgroundColor = '#3498db';
                btn.innerHTML = '<i class="fas fa-sync-alt"></i> Updating...';
            });
        });
    });
</script>
</body>
</html>