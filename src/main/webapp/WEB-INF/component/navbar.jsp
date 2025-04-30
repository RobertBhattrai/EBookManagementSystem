<%@ page import="models.UserModel" %>
<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta charset="UTF-8">
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
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <a href="home.jsp" class="brand">
        <span class="brand-logo"><i class="fas fa-book-reader"></i></span>
        <span class="brand-text">eBook Store</span>
    </a>

    <ul class="nav-links">
        <li class="nav-item">
            <a href="home.jsp" class="nav-link">
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
</body>
</html>