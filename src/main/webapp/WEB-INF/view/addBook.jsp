<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/29/2025
  Time: 11:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
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
        <h1><i class="fas fa-book-medical"></i> Add New Book</h1>
        <p>Fill in the details to add a new book to the collection</p>
    </div>

    <%-- Display server-side errors if any --%>
    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="server-error">
        <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <form id="addBookForm" class="book-form" action="AddBookServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="bookName">Book Title *</label>
            <input type="text" id="bookName" name="bookName" class="form-control"
                   value="<%= request.getParameter("bookName") != null ? request.getParameter("bookName") : "" %>" required>
            <% if(request.getAttribute("bookNameError") != null) { %>
            <div class="error-message"><%= request.getAttribute("bookNameError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="authorName">Author Name *</label>
            <input type="text" id="authorName" name="authorName" class="form-control"
                   value="<%= request.getParameter("authorName") != null ? request.getParameter("authorName") : "" %>" required>
            <% if(request.getAttribute("authorNameError") != null) { %>
            <div class="error-message"><%= request.getAttribute("authorNameError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="price">Price (₹) *</label>
            <input type="number" id="price" name="price" class="form-control" min="1"
                   value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>" required>
            <% if(request.getAttribute("priceError") != null) { %>
            <div class="error-message"><%= request.getAttribute("priceError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="bookCategory">Category *</label>
            <select id="bookCategory" name="bookCategory" class="form-select" required>
                <option value="">Select a category</option>
                <option value="Fiction" <%= "Fiction".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Fiction</option>
                <option value="Non-Fiction" <%= "Non-Fiction".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Non-Fiction</option>
                <option value="Science" <%= "Science".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Science</option>
                <option value="History" <%= "History".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>History</option>
                <option value="Biography" <%= "Biography".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Biography</option>
                <option value="Technology" <%= "Technology".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Technology</option>
                <option value="Children" <%= "Children".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Children</option>
                <option value="Other" <%= "Other".equals(request.getParameter("bookCategory")) ? "selected" : "" %>>Other</option>
            </select>
            <% if(request.getAttribute("categoryError") != null) { %>
            <div class="error-message"><%= request.getAttribute("categoryError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="available">Quantity Available *</label>
            <input type="number" id="available" name="available" class="form-control" min="0"
                   value="<%= request.getParameter("available") != null ? request.getParameter("available") : "" %>" required>
            <% if(request.getAttribute("availableError") != null) { %>
            <div class="error-message"><%= request.getAttribute("availableError") %></div>
            <% } %>
        </div>

        <div class="form-group">
            <label for="photo">Book Cover Image *</label>
            <input type="file" id="photo" name="photo" class="form-control" accept="image/*" required>
            <% if(request.getAttribute("photoError") != null) { %>
            <div class="error-message"><%= request.getAttribute("photoError") %></div>
            <% } %>
        </div>

        <div class="form-group" style="text-align: center;">
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> Add Book
            </button>
        </div>
    </form>
</div>
</body>
</html>