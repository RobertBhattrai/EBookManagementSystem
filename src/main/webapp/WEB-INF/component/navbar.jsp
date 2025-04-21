<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EBook Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Include Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .active-link {
            color: #3b82f6;
            font-weight: 600;
        }
        .nav-link {
            display: flex;
            align-items: center;
            font-size: 0.875rem;
            font-weight: 500;
            transition: color 0.2s;
        }
        .nav-link:hover {
            color: #3b82f6;
        }
        .mobile-menu {
            display: none;
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            width: 250px;
            background-color: white;
            box-shadow: -2px 0 5px rgba(0,0,0,0.1);
            z-index: 50;
            padding: 1rem;
            overflow-y: auto;
        }
        .mobile-menu.open {
            display: block;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0,0,0,0.5);
            z-index: 40;
        }
        .overlay.open {
            display: block;
        }
        @media (min-width: 768px) {
            .desktop-menu {
                display: flex;
            }
            .mobile-menu-button {
                display: none;
            }
        }
        @media (max-width: 767px) {
            .desktop-menu {
                display: none;
            }
            .mobile-menu-button {
                display: block;
            }
        }
    </style>
</head>
<body>
<nav class="border-b">
    <div class="flex h-16 items-center px-4 md:px-6">
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 font-semibold">
            <i class="fas fa-book text-xl"></i>
            <span class="hidden md:inline-block">EBook Management</span>
        </a>

        <!-- Desktop Navigation -->
        <div class="ml-auto desktop-menu items-center gap-4">
            <a href="${pageContext.request.contextPath}/"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-home mr-2 text-sm"></i>
                Home
            </a>
            <a href="${pageContext.request.contextPath}/recent-books"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/recent-books' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-book mr-2 text-sm"></i>
                Recent Books
            </a>
            <a href="${pageContext.request.contextPath}/new-books"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/new-books' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-book mr-2 text-sm"></i>
                New Books
            </a>
            <a href="${pageContext.request.contextPath}/old-books"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/old-books' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-book mr-2 text-sm"></i>
                Old Books
            </a>
            <a href="${pageContext.request.contextPath}/settings"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/settings' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-cog mr-2 text-sm"></i>
                Settings
            </a>
            <a href="${pageContext.request.contextPath}/contact"
               class="nav-link mr-4 ${pageContext.request.servletPath == '/contact' ? 'active-link' : 'text-gray-500'}">
                <i class="fas fa-comment mr-2 text-sm"></i>
                Contact Us
            </a>
            <div class="ml-4 flex items-center gap-2">
                <a href="${pageContext.request.contextPath}/login"
                   class="px-3 py-1 text-sm border border-gray-300 rounded-md hover:bg-gray-100 transition-colors">
                    Login
                </a>
                <a href="/WEB-INF/view/register.jsp"
                   class="px-3 py-1 text-sm bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors">
                    Register
                </a>
            </div>
        </div>

        <!-- Mobile Navigation Button -->
        <button class="ml-auto mobile-menu-button" id="menuButton">
            <i class="fas fa-bars text-xl"></i>
            <span class="sr-only">Toggle menu</span>
        </button>
    </div>
</nav>

<!-- Mobile Menu -->
<div class="overlay" id="overlay"></div>
<div class="mobile-menu" id="mobileMenu">
    <div class="flex justify-end">
        <button id="closeMenuButton">
            <i class="fas fa-times text-xl"></i>
        </button>
    </div>
    <div class="flex flex-col space-y-4 mt-8">
        <a href="${pageContext.request.contextPath}/"
           class="nav-link py-2 ${pageContext.request.servletPath == '/' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-home mr-2"></i>
            Home
        </a>
        <a href="${pageContext.request.contextPath}/recent-books"
           class="nav-link py-2 ${pageContext.request.servletPath == '/recent-books' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-book mr-2"></i>
            Recent Books
        </a>
        <a href="${pageContext.request.contextPath}/new-books"
           class="nav-link py-2 ${pageContext.request.servletPath == '/new-books' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-book mr-2"></i>
            New Books
        </a>
        <a href="${pageContext.request.contextPath}/old-books"
           class="nav-link py-2 ${pageContext.request.servletPath == '/old-books' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-book mr-2"></i>
            Old Books
        </a>
        <a href="${pageContext.request.contextPath}/settings"
           class="nav-link py-2 ${pageContext.request.servletPath == '/settings' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-cog mr-2"></i>
            Settings
        </a>
        <a href="${pageContext.request.contextPath}/contact"
           class="nav-link py-2 ${pageContext.request.servletPath == '/contact' ? 'active-link' : 'text-gray-500'}">
            <i class="fas fa-comment mr-2"></i>
            Contact Us
        </a>
        <div class="flex flex-col gap-2 pt-4 border-t">
            <a href="${pageContext.request.contextPath}/login"
               class="px-3 py-2 text-center border border-gray-300 rounded-md hover:bg-gray-100 transition-colors">
                Login
            </a>
            <a href="${pageContext.request.contextPath}/register"
               class="px-3 py-2 text-center bg-blue-600 text-white rounded-md hover:bg-blue-700 transition-colors">
                Register
            </a>
        </div>
    </div>
</div>

<script>
    // Mobile menu functionality
    const menuButton = document.getElementById('menuButton');
    const closeMenuButton = document.getElementById('closeMenuButton');
    const mobileMenu = document.getElementById('mobileMenu');
    const overlay = document.getElementById('overlay');

    menuButton.addEventListener('click', () => {
        mobileMenu.classList.add('open');
        overlay.classList.add('open');
        document.body.style.overflow = 'hidden';
    });

    function closeMenu() {
        mobileMenu.classList.remove('open');
        overlay.classList.remove('open');
        document.body.style.overflow = '';
    }

    closeMenuButton.addEventListener('click', closeMenu);
    overlay.addEventListener('click', closeMenu);
</script>
</body>
</html>
