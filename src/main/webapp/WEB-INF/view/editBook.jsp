<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 10:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.BookModel" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
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

        .admin-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h1 {
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .book-form {
            background: white;
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
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
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .form-select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            background-color: white;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--secondary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #27ae60;
        }

        .file-label {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--light-color);
            color: var(--dark-color);
            border: 1px dashed #ddd;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            width: 100%;
        }

        .file-label:hover {
            background-color: #e0e0e0;
        }

        .error-message {
            color: var(--accent-color);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .server-error {
            color: var(--accent-color);
            margin-bottom: 1rem;
            text-align: center;
        }

        @media (max-width: 600px) {
            .admin-container {
                padding: 0 0.5rem;
            }

            .book-form {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="admin/navbar.jsp" %>

<div class="admin-container">
    <div class="form-header">
        <h1><i class="fas fa-edit"></i> Edit Book</h1>
        <p>Update the book details</p>
    </div>

    <%
        BookModel book = (BookModel) request.getAttribute("book");
        if (book != null) {
    %>
    <form id="editBookForm" class="book-form" action="EditBookServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="bookId" value="<%= book.getBookId() %>">

        <div class="form-group">
            <label for="bookName">Book Title *</label>
            <input type="text" id="bookName" name="bookName" class="form-control"
                   value="<%= book.getBookName() %>" required>
        </div>

        <div class="form-group">
            <label for="author">Author Name *</label>
            <input type="text" id="author" name="author" class="form-control"
                   value="<%= book.getAuthor() %>" required>
        </div>

        <div class="form-group">
            <label for="price">Price (₹) *</label>
            <input type="number" id="price" name="price" class="form-control"
                   value="<%= book.getPrice() %>" min="1" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="category">Category *</label>
            <select id="category" name="category" class="form-select" required>
                <option value="Fiction" <%= "Fiction".equals(book.getCategory()) ? "selected" : "" %>>Fiction</option>
                <option value="Non-Fiction" <%= "Non-Fiction".equals(book.getCategory()) ? "selected" : "" %>>Non-Fiction</option>
                <option value="Science" <%= "Science".equals(book.getCategory()) ? "selected" : "" %>>Science</option>
                <option value="History" <%= "History".equals(book.getCategory()) ? "selected" : "" %>>History</option>
                <option value="Biography" <%= "Biography".equals(book.getCategory()) ? "selected" : "" %>>Biography</option>
                <option value="Technology" <%= "Technology".equals(book.getCategory()) ? "selected" : "" %>>Technology</option>
                <option value="Children" <%= "Children".equals(book.getCategory()) ? "selected" : "" %>>Children</option>
                <option value="Other" <%= "Other".equals(book.getCategory()) ? "selected" : "" %>>Other</option>
            </select>
        </div>

        <div class="form-group">
            <label for="available">Quantity Available *</label>
            <input type="number" id="available" name="available" class="form-control"
                   value="<%= book.getStatus() %>" min="0" required>
        </div>

        <div class="form-group">
            <label for="photo">Book Cover Image</label>
            <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
            <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
            <div class="current-image">
                <p>Current Image: <%= book.getPhoto() %></p>
                <img src="uploads/<%= book.getPhoto() %>" alt="Current Cover" style="max-width: 100px;">
            </div>
            <% } %>
        </div>

        <div class="form-group" style="text-align: center;">
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> Update Book
            </button>
            <a href="${pageContext.request.contextPath}/ViewAllBook" class="btn" style="background-color: var(--dark-color);">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>
    </form>
    <% } else { %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> Book not found
    </div>
    <a href="${pageContext.request.contextPath}/ViewAllBook" class="btn" style="display: block; text-align: center; margin-top: 20px;">
        <i class="fas fa-arrow-left"></i> Back to Book List
    </a>
    <% } %>
</div>
</body>
</html>
