<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 8:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, models.BookModel" %>
<!DOCTYPE html>
<html>
<head>
    <title>View All Books</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* [Keep all your existing CSS styles] */
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

        .book-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .book-table th, .book-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .book-table th {
            background-color: var(--dark-color);
            color: white;
            font-weight: 500;
        }

        .book-table tr:hover {
            background-color: #f9f9f9;
        }

        .book-cover {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 4px;
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

        .add-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--secondary-color);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .add-btn:hover {
            background-color: #27ae60;
        }

        .success-message {
            color: var(--secondary-color);
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
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-book"></i> Book Inventory</h1>
        <p>Manage your book collection</p>
    </div>

    <%-- Display success message from session --%>
    <%
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null && !successMessage.isEmpty()) {
    %>
    <div class="success-message">
        <i class="fas fa-check-circle"></i> <%= successMessage %>
    </div>
    <%
            session.removeAttribute("successMessage");
        }
    %>

    <%-- Display error message from session --%>
    <%
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
    </div>
    <%
            session.removeAttribute("errorMessage");
        }
    %>

    <a href="${pageContext.request.contextPath}/AddBookServlet" class="add-btn">
        <i class="fas fa-plus"></i> Add New Book
    </a>

    <table class="book-table">
        <thead>
        <tr>
            <th>Cover</th>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Category</th>
            <th>Available</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<BookModel> books = (List<BookModel>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (BookModel book : books) {
        %>
        <tr>
            <td>
                <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
                <img src="uploads/<%= book.getPhoto() %>" alt="Book Cover" class="book-cover">
                <% } else { %>
                <i class="fas fa-book" style="font-size: 2em;"></i>
                <% } %>
            </td>
            <td><%= book.getBookName() %></td>
            <td><%= book.getAuthor() %></td>
            <td>₹<%= book.getPrice() %></td>
            <td><%= book.getCategory() %></td>
            <td><%= book.getStatus() %></td>
            <td>
                <a href="EditBookServlet?id=<%= book.getBookId() %>" class="action-btn edit-btn">
                    <i class="fas fa-edit"></i> Edit
                </a>
                <a href="DeleteBookServlet?id=<%= book.getBookId() %>"
                   class="action-btn delete-btn"
                   onclick="return confirm('Are you sure you want to delete this book?');">
                    <i class="fas fa-trash"></i> Delete
                </a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="7" style="text-align: center;">No books found</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>