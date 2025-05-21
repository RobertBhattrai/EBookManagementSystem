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
//    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
//    if (loggedInUser == null) {
//        response.sendRedirect(request.getContextPath() + "/LoginServlet");
//        return;
//    }

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
        /* Base Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Back Link */
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #3498db;
            text-decoration: none;
            font-size: 1rem;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: #2980b9;
        }

        .back-link i {
            margin-right: 5px;
        }

        /* Book Detail Container */
        .book-detail-container {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .book-image-container {
            flex: 1;
            min-width: 300px;
            max-width: 400px;
        }

        .book-image {
            width: 100%;
            height: auto;
            border-radius: 4px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .book-info-container {
            flex: 2;
            min-width: 300px;
        }

        /* Book Info Styles */
        .book-title {
            font-size: 2.2rem;
            margin: 0 0 10px 0;
            color: #2c3e50;
        }

        .book-author {
            font-size: 1.2rem;
            color: #7f8c8d;
            margin: 0 0 20px 0;
        }

        .book-price {
            font-size: 1.8rem;
            font-weight: bold;
            color: #e74c3c;
            margin: 0 0 30px 0;
        }

        /* Meta Information */
        .book-meta {
            margin-bottom: 30px;
        }

        .meta-item {
            margin-bottom: 15px;
        }

        .meta-label {
            font-weight: bold;
            color: #2c3e50;
            display: inline-block;
            width: 150px;
        }

        .meta-value {
            color: #34495e;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 12px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn i {
            margin-right: 8px;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .book-detail-container {
                flex-direction: column;
                gap: 20px;
            }

            .book-image-container, .book-info-container {
                min-width: 100%;
            }

            .book-title {
                font-size: 1.8rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<%@include file="../component/navbar.jsp"%>

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