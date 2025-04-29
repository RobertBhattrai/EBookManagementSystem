<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/29/2025
  Time: 10:22 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Navigation</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --text-light: #ecf0f1;
            --text-dark: #2c3e50;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background-color: var(--primary-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .brand {
            display: flex;
            align-items: center;
            color: var(--text-light);
            text-decoration: none;
        }

        .brand-logo {
            font-size: 1.8rem;
            margin-right: 0.8rem;
            color: var(--secondary-color);
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
            position: relative;
        }

        .nav-link {
            color: var(--text-light);
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            padding: 0.5rem 0;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }

        .nav-link:hover {
            color: var(--secondary-color);
        }

        .nav-link i {
            margin-right: 0.5rem;
            font-size: 1.1rem;
        }

        .logout-btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 0.5rem 1.2rem;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s ease;
            display: flex;
            align-items: center;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .logout-btn i {
            margin-right: 0.5rem;
        }

        /* Responsive design */
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
<nav class="navbar">
    <a href="home.jsp" class="brand">
        <span class="brand-text">eBook Admin</span>
    </a>

    <ul class="nav-links">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">
                 Home
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/" class="nav-link">
                 Main Site
            </a>
        </li>
        <li class="nav-item">
            <button class="logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/LogoutServlet'">
                Logout
            </button>
        </li>
    </ul>
</nav>
</body>
</html>