<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/29/2025
  Time: 7:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.UserModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

    if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
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

    .admin-container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1rem;
    }

    .admin-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .admin-header h1 {
        color: var(--dark-color);
        margin-bottom: 0.5rem;
    }

    .admin-header p {
        color: #7f8c8d;
    }

    .actions-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
    }

    .action-card {
        background: white;
        border-radius: 8px;
        padding: 1.5rem;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        cursor: pointer;
        text-decoration: none;
        color: var(--dark-color);
    }

    .action-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }

    .card-icon {
        font-size: 2.5rem;
        margin-bottom: 1rem;
        display: inline-block;
    }

    .card-title {
        font-size: 1.25rem;
        margin-bottom: 0.5rem;
        font-weight: 600;
    }

    .card-desc {
        color: #7f8c8d;
        font-size: 0.9rem;
    }

    /* Color coding for cards */
    .add-book {
        border-top: 4px solid var(--secondary-color);
    }

    .view-books {
        border-top: 4px solid var(--primary-color);
    }

    .view-users {
        border-top: 4px solid var(--accent-color);
    }

    .view-orders {
        border-top: 4px solid #f39c12;
    }

    @media (max-width: 600px) {
        .actions-container {
            grid-template-columns: 1fr;
        }
    }
</style>
<body>
<%@ include file="navbar.jsp" %>

<h2>Welcome, Admin <%= loggedInUser.getName() %>!</h2>
<p>Email: <%= loggedInUser.getEmail() %></p>
<p>Role: <%= loggedInUser.getRole() %></p>


<h3>Admin Actions</h3>
<div class="admin-container">
    <div class="admin-header">
        <h1>Admin Dashboard</h1>
        <p>Manage your bookstore administration tasks</p>
    </div>

    <div class="actions-container">
        <!-- Add Book Card -->
        <a href="${pageContext.request.contextPath}/AddBookServlet" class="action-card add-book">
            <div class="card-icon"><i class="fas fa-book-medical"></i></div>
            <h3 class="card-title">Add Book</h3>
            <p class="card-desc">Add new books to your collection</p>
        </a>

        <!-- View All Books Card -->
        <a href="${pageContext.request.contextPath}/ViewAllBook" class="action-card view-books">
            <div class="card-icon"><i class="fas fa-book-open"></i></div>
            <h3 class="card-title">View All Books</h3>
            <p class="card-desc">Browse and manage all books</p>
        </a>

        <!-- View Users Card -->
        <a href="${pageContext.request.contextPath}/ViewUserServlet" class="action-card view-users">
            <div class="card-icon"><i class="fas fa-users"></i></div>
            <h3 class="card-title">View Users</h3>
            <p class="card-desc">Manage registered users</p>
        </a>

        <!-- View Book Orders Card -->
        <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="action-card view-orders">
            <div class="card-icon"><i class="fas fa-shopping-cart"></i></div>
            <h3 class="card-title">View Book Orders</h3>
            <p class="card-desc">View and manage customer orders</p>
        </a>
    </div>
</div>

</body>
</html>

