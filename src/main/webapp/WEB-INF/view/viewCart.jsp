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

    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cart");
    boolean cartEmpty = request.getAttribute("cartEmpty") != null;
    double totalPrice = 0.0;
    if (!cartEmpty && cartItems != null) {
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
        /* (Keep all previous CSS styles) */

        .quantity-control {
            display: flex;
            align-items: center;
        }

        .quantity-input {
            width: 50px;
            text-align: center;
            margin: 0 5px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .quantity-btn {
            background-color: var(--light-color);
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }

        .quantity-btn:hover {
            background-color: #e0e0e0;
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
                <% if (!cartEmpty && cartItems != null && !cartItems.isEmpty()) { %>
                <span class="cart-count">(<%= cartItems.size() %>)</span>
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
        <% if (cartEmpty || cartItems == null || cartItems.isEmpty()) { %>
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
        <form action="UpdateCartServlet" method="post">
            <table class="cart-table">
                <thead>
                <tr>
                    <th>Book</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Action</th>
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
                        <button type="submit" name="remove" value="<%= item.getBook().getBookId() %>" class="remove-btn">
                            <i class="fas fa-trash-alt"></i>
                        </button>
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
                    <button type="submit" name="update" value="update" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                        <i class="fas fa-sync-alt"></i> Update Cart
                    </button>
                    <a href="CheckoutServlet" class="checkout-btn">
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
            });
        });

        // Auto-submit when quantity changes (optional)
        document.querySelectorAll('.quantity-input').forEach(input => {
            input.addEventListener('change', function() {
                this.closest('form').querySelector('button[name="update"]').click();
            });
        });
    });
</script>
</body>
</html>