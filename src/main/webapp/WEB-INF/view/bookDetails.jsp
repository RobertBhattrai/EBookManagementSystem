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
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }

    BookModel book = (BookModel) request.getAttribute("book");
    if (book == null) {
        response.sendRedirect(request.getContextPath() + "/BrowseBooksServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= book.getBookName() %> - eBook Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>

    </style>
</head>
<body>


<!-- Main Content -->
<div class="container">
    <a href="BrowseBooksServlet" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Browse Books
    </a>

    <div class="book-detail-container">
        <div class="book-image-container">
            <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
            <img src="uploads/<%= book.getPhoto() %>" alt="<%= book.getBookName() %>" class="book-image">
            <% } else { %>
            <div style="width: 300px; height: 400px; background-color: #eee; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-book" style="font-size: 5rem; color: #999;"></i>
            </div>
            <% } %>
        </div>
        <div class="book-info-container">
            <h1 class="book-title"><%= book.getBookName() %></h1>
            <p class="book-author">By <%= book.getAuthor() %></p>
            <p class="book-price">₹<%= String.format("%.2f", book.getPrice()) %></p>

            <div class="book-meta">
                <div class="meta-item">
                    <span class="meta-label">Category:</span>
                    <span class="meta-value"><%= book.getCategory() != null ? book.getCategory() : "N/A" %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Available Quantity:</span>
                    <span class="meta-value"><%= book.getStatus() != null ? book.getStatus() : "N/A" %></span>
                </div>
            </div>

            <div class="action-buttons">
                <form action="CartServlet" method="post" style="display: inline;">
                    <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-cart-plus"></i> Add to Cart
                    </button>
                </form>
                <a href="BrowseBooksServlet" class="btn btn-primary">
                    <i class="fas fa-book-open"></i> Browse More Books
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>