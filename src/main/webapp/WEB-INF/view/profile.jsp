<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 5/4/2025
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.UserModel" %>
<%
    UserModel user = (UserModel) request.getAttribute("user");
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    // Clear messages after displaying
    if (successMessage != null) session.removeAttribute("successMessage");
    if (errorMessage != null) session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile - eBook Store</title>
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
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .profile-container {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .profile-title {
            font-size: 1.8rem;
            color: var(--dark-color);
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: var(--light-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--primary-color);
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-danger {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .tab-container {
            display: flex;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid #ddd;
        }

        .tab {
            padding: 0.75rem 1.5rem;
            cursor: pointer;
            border-bottom: 2px solid transparent;
        }

        .tab.active {
            border-bottom-color: var(--primary-color);
            font-weight: 500;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="../component/navbar.jsp"%>

<!-- Main Content -->
<div class="container">
    <div class="profile-container">
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

        <div class="profile-header">
            <h1 class="profile-title">User Profile</h1>
            <div class="profile-avatar">
                <i class="fas fa-user"></i>
            </div>
        </div>

        <div class="tab-container">
            <div class="tab active" onclick="openTab('profile')">Profile</div>
            <div class="tab" onclick="openTab('password')">Change Password</div>
        </div>

        <!-- Profile Tab -->
        <div id="profile" class="tab-content active">
            <form action="ProfileServlet" method="post">
                <div class="form-group">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control"
                           value="<%= user.getName() %>" required>
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control"
                           value="<%= user.getEmail() %>" required>
                </div>

                <div class="form-group">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="form-control"
                           value="<%= user.getPhone() %>" required>
                </div>

                <div class="form-group">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" id="address" name="address" class="form-control"
                           value="<%= user.getAddress() %>" required>
                </div>

                <div class="form-group">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-control"
                           value="<%= user.getUsername() %>" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Changes
                </button>
            </form>
        </div>

        <!-- Change Password Tab -->
        <div id="password" class="tab-content">
            <form action="ChangePasswordServlet" method="post">
                <div class="form-group">
                    <label for="currentPassword" class="form-label">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword"
                           class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="newPassword" class="form-label">New Password</label>
                    <input type="password" id="newPassword" name="newPassword"
                           class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-key"></i> Change Password
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    function openTab(tabName) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });

        // Show the selected tab content
        document.getElementById(tabName).classList.add('active');

        // Update tab styling
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
        });
        event.currentTarget.classList.add('active');
    }

    // Password confirmation validation
    document.querySelector('form[action="ChangePasswordServlet"]').addEventListener('submit', function(e) {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('New password and confirmation do not match');
            return false;
        }

        if (newPassword.length < 8) {
            e.preventDefault();
            alert('Password must be at least 8 characters long');
            return false;
        }

        return true;
    });
</script>
</body>
</html>
