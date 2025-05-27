<%@ page import="models.UserModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");
//
//    if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
//        response.sendRedirect(request.getContextPath() + "/LoginServlet");
//        return;
//    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | eBook Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #3a56d4;
            --secondary: #4cc9f0;
            --accent: #f72585;
            --success: #4ade80;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #1e293b;
            --light: #f8fafc;
            --gray: #94a3b8;
            --border-radius: 12px;
            --shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f1f5f9;
            color: var(--dark);
            line-height: 1.6;
        }

        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Admin Header */
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
        }

        .admin-info h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
            color: var(--dark);
        }

        .admin-info p {
            color: var(--gray);
            font-size: 0.95rem;
        }

        .admin-stats {
            display: flex;
            gap: 15px;
        }

        .stat-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        /* Quick Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--shadow);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .stat-title {
            font-size: 0.95rem;
            color: var(--gray);
            font-weight: 500;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .stat-change {
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .positive {
            color: var(--success);
        }

        .negative {
            color: var(--danger);
        }

        /* Action Cards */
        .action-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 25px;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-decoration: none;
            color: var(--dark);
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
        }

        .action-icon {
            width: 60px;
            height: 60px;
            border-radius: var(--border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 20px;
            color: white;
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .action-desc {
            color: var(--gray);
            font-size: 0.95rem;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .action-link {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--primary);
            font-weight: 500;
            font-size: 0.95rem;
        }

        /* Color Variants */
        .bg-primary {
            background-color: var(--primary);
        }

        .bg-secondary {
            background-color: var(--secondary);
        }

        .bg-accent {
            background-color: var(--accent);
        }

        .bg-warning {
            background-color: var(--warning);
        }

        .text-primary {
            color: var(--primary);
        }

        .text-secondary {
            color: var(--secondary);
        }

        .text-accent {
            color: var(--accent);
        }

        .text-warning {
            color: var(--warning);
        }

        /* Recent Activity */
        .recent-activity {
            background: white;
            border-radius: var(--border-radius);
            padding: 20px;
            box-shadow: var(--shadow);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(67, 97, 238, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            flex-shrink: 0;
        }

        .activity-content {
            flex-grow: 1;
        }

        .activity-title {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .activity-time {
            color: var(--gray);
            font-size: 0.85rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .admin-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .admin-stats {
                width: 100%;
                justify-content: space-between;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .stats-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="admin-container">
    <!-- Admin Header with Stats -->
    <div class="admin-header">
        <div class="admin-info">
            <h1>Welcome Back, <%= loggedInUser.getName() %>!</h1>
            <p>Manage your here.</p>
        </div>
        <div class="admin-stats">
            <div class="stat-badge">
                <i class="fas fa-user-shield"></i>
                Administrator
            </div>
            <div class="stat-badge">
                <i class="fas fa-calendar-day"></i>
                <%= new java.text.SimpleDateFormat("MMMM d, yyyy").format(new java.util.Date()) %>
            </div>
        </div>
    </div>

    <!-- Main Actions Grid -->
    <div class="dashboard-grid">
        <a href="${pageContext.request.contextPath}/AddBookServlet" class="action-card">
            <div class="action-icon bg-primary">
                <i class="fas fa-book-medical"></i>
            </div>
            <h3 class="action-title">Add New Book</h3>
            <p class="action-desc">Add a new book to your store's collection with details like title, author, price, and category.</p>
            <span class="action-link">
                Go to Add Book <i class="fas fa-arrow-right"></i>
            </span>
        </a>

        <a href="${pageContext.request.contextPath}/ViewAllBook" class="action-card">
            <div class="action-icon bg-secondary">
                <i class="fas fa-book-open"></i>
            </div>
            <h3 class="action-title">Manage Books</h3>
            <p class="action-desc">View, edit, or remove books from your inventory. Update stock levels and pricing.</p>
            <span class="action-link">
                Manage Books <i class="fas fa-arrow-right"></i>
            </span>
        </a>

        <a href="${pageContext.request.contextPath}/ViewUserServlet" class="action-card">
            <div class="action-icon bg-accent">
                <i class="fas fa-user-cog"></i>
            </div>
            <h3 class="action-title">User Management</h3>
            <p class="action-desc">View all registered users, manage roles, and handle user accounts.</p>
            <span class="action-link">
                Manage Users <i class="fas fa-arrow-right"></i>
            </span>
        </a>

        <a href="${pageContext.request.contextPath}/AdminOrderServlet" class="action-card">
            <div class="action-icon bg-warning">
                <i class="fas fa-clipboard-list"></i>
            </div>
            <h3 class="action-title">Order Management</h3>
            <p class="action-desc">View and process customer orders, update status, and handle returns.</p>
            <span class="action-link">
                View Orders <i class="fas fa-arrow-right"></i>
            </span>
        </a>
    </div>


<script>
    // You can add dynamic functionality here
    document.addEventListener('DOMContentLoaded', function() {
        // Example: Animate stats counting up
        const statValues = document.querySelectorAll('.stat-value');

        statValues.forEach(stat => {
            const target = parseInt(stat.textContent.replace(/,/g, ''));
            const duration = 2000;
            const step = target / (duration / 16);
            let current = 0;

            const interval = setInterval(() => {
                current += step;
                if (current >= target) {
                    clearInterval(interval);
                    stat.textContent = target.toLocaleString();
                } else {
                    stat.textContent = Math.floor(current).toLocaleString();
                }
            }, 16);
        });
    });
</script>
</body>
</html>