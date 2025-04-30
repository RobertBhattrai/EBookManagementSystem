<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 12:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    List<UserModel> users = (List<UserModel>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View All Users</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --accent-color: #e74c3c;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: var(--dark-color);
            margin-bottom: 10px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .user-table th, .user-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .user-table th {
            background-color: var(--dark-color);
            color: white;
            font-weight: 500;
        }

        .user-table tr:hover {
            background-color: #f9f9f9;
        }

        .action-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .edit-btn {
            background-color: var(--primary-color);
        }

        .delete-btn {
            background-color: var(--accent-color);
        }

        .success-message {
            color: #2ecc71;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #e8f8f0;
            border-radius: 4px;
        }

        .error-message {
            color: var(--accent-color);
            margin-bottom: 20px;
            padding: 10px;
            background-color: #fde8e8;
            border-radius: 4px;
        }

        @media (max-width: 600px) {
            .container {
                padding: 0 10px;
            }

            .user-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<%@ include file="admin/navbar.jsp" %>

<div class="container">
    <div class="header">
        <h1><i class="fas fa-users"></i> User Management</h1>
        <p>Manage all registered users</p>
    </div>

    <%-- Display messages from session --%>
    <%
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
    %>
    <div class="success-message">
        <i class="fas fa-check-circle"></i> <%= successMessage %>
    </div>
    <% session.removeAttribute("successMessage"); %>
    <% } %>

    <%
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
    </div>
    <% session.removeAttribute("errorMessage"); %>
    <% } %>

    <table class="user-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Username</th>
            <th>Role</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (users != null && !users.isEmpty()) {
            for (UserModel user : users) { %>
        <tr>
            <td><%= user.getId() %></td>
            <td><%= user.getName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getPhone() %></td>
            <td><%= user.getAddress() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getRole() %></td>
            <td>
                <a href="DeleteUserServlet?id=<%= user.getId() %>"
                   class="action-btn delete-btn"
                   onclick="return confirm('Are you sure you want to delete this user?');">
                    <i class="fas fa-trash"></i> Delete
                </a>
            </td>
        </tr>
        <% }
        } else { %>
        <tr>
            <td colspan="8" style="text-align: center;">No users found</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
