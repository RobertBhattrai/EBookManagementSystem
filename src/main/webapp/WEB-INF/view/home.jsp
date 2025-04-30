<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="models.UserModel" %>--%>
<%--<%--%>
<%--    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");--%>
<%--    if (loggedInUser == null) {--%>
<%--        response.sendRedirect(request.getContextPath() + "/LoginServlet");--%>
<%--        return;--%>
<%--    }--%>
<%--%>--%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - eBook Store</title>
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

        /* Main Content Styles */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 2rem;
            padding: 2rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .welcome-section h1 {
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .welcome-section p {
            color: #7f8c8d;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .feature-card {
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .feature-title {
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
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
    </style>
</head>
<body>
<%@ include file="../component/navbar.jsp"%>

<!-- Main Content -->
<div class="container">
    <div class="welcome-section">
        <h1>Welcome, <%= loggedInUser.getName() %>!</h1>
        <p>Discover your next favorite book from our extensive collection</p>
        <a href="BrowseBooksServlet" class="btn">
            <i class="fas fa-book-open"></i> Browse Books
        </a>
    </div>

    <div class="features">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-book"></i>
            </div>
            <h3 class="feature-title">Wide Selection</h3>
            <p>Explore thousands of books across various genres and categories.</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-truck"></i>
            </div>
            <h3 class="feature-title">Fast Delivery</h3>
            <p>Get your books delivered quickly with our reliable shipping.</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-headset"></i>
            </div>
            <h3 class="feature-title">24/7 Support</h3>
            <p>Our customer service team is always ready to assist you.</p>
        </div>
    </div>
</div>
</body>
</html>