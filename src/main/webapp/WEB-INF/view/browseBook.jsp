<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 3:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.BookModel" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    List<BookModel> books = (List<BookModel>) request.getAttribute("books");
    String searchQuery = request.getParameter("search") != null ? request.getParameter("search") : "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Books - eBook Store</title>
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

        /* Navigation Bar - Same as home.jsp */
        .navbar {
            background-color: var(--dark-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* ... (include all navbar styles from home.jsp) ... */

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h1 {
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .search-bar {
            display: flex;
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .search-input {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 1px solid #ddd;
            border-radius: 4px 0 0 4px;
            font-size: 1rem;
        }

        .search-button {
            padding: 0 1.5rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 0 4px 4px 0;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-button:hover {
            background-color: #2980b9;
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .book-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .book-card:hover {
            transform: translateY(-5px);
        }

        .book-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }

        .book-details {
            padding: 1rem;
        }

        .book-title {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 600;
        }

        .book-author {
            color: #7f8c8d;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .book-price {
            font-weight: bold;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .book-actions {
            display: flex;
            justify-content: space-between;
        }

        .btn {
            padding: 0.5rem 1rem;
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

        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: #27ae60;
        }

        .no-books {
            text-align: center;
            padding: 2rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }

        .pagination a {
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: var(--dark-color);
        }

        .pagination a.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        @media (max-width: 600px) {
            .books-grid {
                grid-template-columns: 1fr;
            }

            .search-bar {
                flex-direction: column;
            }

            .search-input {
                border-radius: 4px;
                margin-bottom: 0.5rem;
            }

            .search-button {
                border-radius: 4px;
                padding: 0.75rem;
            }
        }

        /* Navigation Bar Styles */
        .navbar {
            background-color: var(--dark-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
        }

        .nav-link:hover {
            color: var(--primary-color);
        }

        .nav-link i {
            margin-right: 0.5rem;
            font-size: 1.1rem;
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
        }



        .user-profile {
            display: flex;
            align-items: center;
            color: white;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
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
        <h1><i class="fas fa-book-open"></i> Browse Our Collection</h1>
        <p>Find your next favorite book</p>
    </div>

    <!-- Search Form -->
    <form action="BrowseBooksServlet" method="get" class="search-bar">
        <input type="text" name="search" class="search-input" placeholder="Search by title or author..." value="<%= searchQuery %>">
        <button type="submit" class="search-button">
            <i class="fas fa-search"></i>
        </button>
    </form>

    <!-- Books Grid -->
    <% if (books != null && !books.isEmpty()) { %>
    <div class="books-grid">
        <% for (BookModel book : books) { %>
        <div class="book-card">
            <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
            <img src="uploads/<%= book.getPhoto() %>" alt="<%= book.getBookName() %>" class="book-image">
            <% } else { %>
            <div style="height: 200px; background-color: #eee; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-book" style="font-size: 3rem; color: #999;"></i>
            </div>
            <% } %>
            <div class="book-details">
                <h3 class="book-title"><%= book.getBookName() %></h3>
                <p class="book-author">By <%= book.getAuthor() %></p>
                <p class="book-price">₹<%= String.format("%.2f", book.getPrice()) %></p>
                <div class="book-actions">
                    <a href="BookDetailsServlet?id=<%= book.getBookId() %>" class="btn btn-primary">
                        <i class="fas fa-info-circle"></i> Details
                    </a>
                    <a href="AddToCartServlet?id=<%= book.getBookId() %>" class="btn btn-secondary">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </a>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Pagination -->
    <div class="pagination">
        <a href="#">&laquo;</a>
        <a href="#" class="active">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">&raquo;</a>
    </div>
    <% } else { %>
    <div class="no-books">
        <h3>No books found</h3>
        <p>We couldn't find any books matching your search.</p>
        <a href="BrowseBooksServlet" class="btn btn-primary" style="margin-top: 1rem;">
            <i class="fas fa-book-open"></i> Browse All Books
        </a>
    </div>
    <% } %>
</div>
</body>
</html>
