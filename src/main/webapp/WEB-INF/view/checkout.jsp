<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 5/4/2025
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.CartItem" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
//    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
//    if (loggedInUser == null) {
//        response.sendRedirect(request.getContextPath() + "/LoginServlet");
//        return;
//    }

    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    double totalPrice = (double) request.getAttribute("totalPrice");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - eBook Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --accent-color: #e74c3c;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
        }

        /* Navigation Bar - Same as other pages */
        .navbar {
            background-color: var(--dark-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* ... (include all navbar styles from other pages) ... */

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .checkout-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .checkout-form {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .checkout-summary {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            align-self: start;
        }

        .section-title {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--light-color);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .payment-methods {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .payment-method {
            display: flex;
            align-items: center;
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-method:hover {
            border-color: var(--primary-color);
        }

        .payment-method input {
            margin-right: 0.5rem;
        }

        .order-summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .order-total {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid var(--dark-color);
        }

        .checkout-btn {
            width: 100%;
            padding: 1rem;
            background-color: var(--secondary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: background-color 0.3s ease;
        }

        .checkout-btn:hover {
            background-color: #27ae60;
        }

        .cart-item {
            display: flex;
            margin-bottom: 1rem;
        }

        .cart-item-image {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 1rem;
        }

        .cart-item-details {
            flex: 1;
        }

        .cart-item-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .cart-item-author {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .cart-item-price {
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<%@include file="../component/navbar.jsp"%>

<!-- Main Content -->
<div class="container">
    <form action="CheckoutServlet" method="post">
        <div class="checkout-container">
            <div class="checkout-form">
                <h2 class="section-title">Shipping Information</h2>

                <div class="form-group">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" id="name" name="name" class="form-input"
                           value="<%= loggedInUser.getName() %>" required>
                </div>

                <div class="form-group">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="address1" class="form-label">Address Line 1</label>
                    <input type="text" id="address1" name="address1" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="address2" class="form-label">Address Line 2</label>
                    <input type="text" id="address2" name="address2" class="form-input">
                </div>

                <div class="form-group">
                    <label for="landmark" class="form-label">Landmark</label>
                    <input type="text" id="landmark" name="landmark" class="form-input">
                </div>

                <div class="form-group">
                    <label for="city" class="form-label">City</label>
                    <input type="text" id="city" name="city" class="form-input" required>
                </div>

                <div class="form-group">
                    <label for="pincode" class="form-label">Pincode</label>
                    <input type="text" id="pincode" name="pincode" class="form-input" required>
                </div>

                <h2 class="section-title">Payment Method</h2>

                <div class="payment-methods">
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="Credit Card" checked>
                        Credit Card
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="Debit Card">
                        Debit Card
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="Net Banking" disabled>
                        Net Banking
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="UPI" disabled>
                        UPI
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="Cash on Delivery">
                        Cash on Delivery
                    </label>
                </div>

                <button type="submit" class="checkout-btn">
                    <i class="fas fa-credit-card"></i> Place Order
                </button>
            </div>

            <div class="checkout-summary">
                <h2 class="section-title">Order Summary</h2>

                <% for (CartItem item : cartItems) { %>
                <div class="cart-item">
                    <% if (item.getBook().getPhoto() != null && !item.getBook().getPhoto().isEmpty()) { %>
                    <img src="uploads/<%= item.getBook().getPhoto() %>" alt="<%= item.getBook().getBookName() %>" class="cart-item-image">
                    <% } else { %>
                    <div style="width: 60px; height: 80px; background-color: #eee; display: flex; align-items: center; justify-content: center; border-radius: 4px;">
                        <i class="fas fa-book" style="font-size: 1.5rem; color: #999;"></i>
                    </div>
                    <% } %>
                    <div class="cart-item-details">
                        <div class="cart-item-title"><%= item.getBook().getBookName() %></div>
                        <div class="cart-item-author">By <%= item.getBook().getAuthor() %></div>
                        <div class="cart-item-price">₹<%= String.format("%.2f", item.getBook().getPrice()) %> × <%= item.getQuantity() %></div>
                    </div>
                </div>
                <% } %>

                <div class="order-summary-item">
                    <span>Subtotal:</span>
                    <span>₹<%= String.format("%.2f", totalPrice) %></span>
                </div>
                <div class="order-summary-item">
                    <span>Shipping:</span>
                    <span>FREE</span>
                </div>
                <div class="order-total">
                    <span>Total:</span>
                    <span>₹<%= String.format("%.2f", totalPrice) %></span>
                </div>
            </div>
        </div>

        <% for (CartItem item : cartItems) { %>
        <input type="hidden" name="bookIds" value="<%= item.getBook().getBookId() %>">
        <input type="hidden" name="bookNames" value="<%= item.getBook().getBookName() %>">
        <input type="hidden" name="authorNames" value="<%= item.getBook().getAuthor() %>">
        <input type="hidden" name="quantities" value="<%= item.getQuantity() %>">
        <input type="hidden" name="prices" value="<%= item.getBook().getPrice() %>">
        <% } %>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Auto-fill phone number if available in user profile
        const phoneInput = document.getElementById('phone');
        <% if (loggedInUser.getPhone() != null && !loggedInUser.getPhone().isEmpty()) { %>
        phoneInput.value = '<%= loggedInUser.getPhone() %>';
        <% } %>

        // Form validation
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const pincode = document.getElementById('pincode').value;
            if (!/^\d{6}$/.test(pincode)) {
                e.preventDefault();
                alert('Please enter a valid 6-digit pincode');
                return false;
            }

            const phone = document.getElementById('phone').value;
            if (!/^\d{10}$/.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid 10-digit phone number');
                return false;
            }

            return true;
        });
    });
</script>
</body>
</html>