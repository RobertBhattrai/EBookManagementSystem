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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/style.css">
    <meta charset="UTF-8">
    <style>
        /* Navbar Styles */
        .navbar {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 2rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;

        }

        .brand {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            transition: var(--transition);
        }

        .brand:hover {
            transform: translateY(-2px);
        }

        .brand-logo {
            font-size: 2rem;
            margin-right: 0.8rem;
            color: var(--accent);
        }

        .brand-text {
            font-size: 1.6rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-item {
            margin-left: 1.2rem;
            position: relative;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            padding: 0.8rem 0.5rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            position: relative;
        }

        .nav-link i {
            margin-right: 0.6rem;
            font-size: 1.1rem;
            transition: var(--transition);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 3px;
            background-color: var(--accent);
            transition: var(--transition);
        }

        .nav-link:hover {
            color: var(--accent);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            transition: var(--transition);
            position: relative;
        }

        .user-info:hover {
            color: var(--accent);
            transform: translateY(-2px);
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            margin-right: 0.8rem;
            object-fit: cover;
            border: 2px solid var(--accent);
            transition: var(--transition);
        }

        .user-info:hover .user-avatar {
            transform: scale(1.1);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.3);
        }

        .user-name {
            font-weight: 500;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 0.6rem 1.2rem;
            font-size: 0.9rem;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            color: var(--accent);
            transform: translateY(-2px);
        }

        /* Mobile Menu */
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .navbar {
                flex-wrap: wrap;
                padding: 0.8rem 1.5rem;
            }

            .brand-text {
                font-size: 1.4rem;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                position: relative;
                padding: 0.8rem 1.5rem;
            }

            .menu-toggle {
                display: block;
                order: 1;
            }

            .brand {
                order: 2;
                flex-grow: 1;
                justify-content: center;
            }

            .user-profile {
                order: 3;
            }

            .nav-links {
                display: none;
                flex-direction: column;
                width: 100%;
                background: rgba(0, 0, 0, 0.9);
                position: absolute;
                top: 100%;
                left: 0;
                padding: 1rem 0;
                z-index: 999;
                animation: slideDown 0.3s ease-out;
            }

            .nav-links.active {
                display: flex;
            }

            .nav-item {
                margin: 0;
                width: 100%;
            }

            .nav-link {
                padding: 1rem 1.5rem;
                justify-content: center;
            }

            .nav-link::after {
                display: none;
            }

            .user-profile {
                margin-left: auto;
            }
        }

        @media (max-width: 480px) {
            .brand-text {
                font-size: 1.2rem;
            }

            .user-name {
                display: none;
            }

            .logout-btn span {
                display: none;
            }

            .logout-btn {
                padding: 0.6rem;
                border-radius: 50%;
            }
        }

        /* Animations */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar">
    <button class="menu-toggle" id="mobile-menu">
        <i class="fas fa-bars"></i>
    </button>

    <a href="${pageContext.request.contextPath}/admin" class="brand">
        <span class="brand-logo"><i class="fas fa-book-reader"></i></span>
        <span class="brand-text">E-Book Haven - Admin</span>
    </a>

    <ul class="nav-links" id="nav-links">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">
                <i class="fas fa-home"></i> <span>Home</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/" class="nav-link">
                <i class="fas fa-book-open"></i> <span>Main Site</span>
            </a>
        </li>
    </ul>

    <div class="user-profile">
        <button class="logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/LogoutServlet'">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </button>
    </div>
</nav>

<script>
    // Mobile menu toggle
    const mobileMenu = document.getElementById('mobile-menu');
    const navLinks = document.getElementById('nav-links');

    mobileMenu.addEventListener('click', () => {
        navLinks.classList.toggle('active');
        mobileMenu.innerHTML = navLinks.classList.contains('active') ?
            '<i class="fas fa-times"></i>' : '<i class="fas fa-bars"></i>';
    });

    // Close menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.navbar') && navLinks.classList.contains('active')) {
            navLinks.classList.remove('active');
            mobileMenu.innerHTML = '<i class="fas fa-bars"></i>';
        }
    });
</script>
</body>
</html>