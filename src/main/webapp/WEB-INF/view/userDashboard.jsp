<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard | E-Book Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --dark: #1b263b;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark);
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            background: var(--dark);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .user-profile {
            text-align: center;
            padding: 0 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1rem;
            border: 3px solid var(--accent);
        }

        .user-name {
            font-size: 1.2rem;
            margin-bottom: 0.2rem;
        }

        .user-email {
            font-size: 0.8rem;
            color: #ccc;
        }

        .nav-menu {
            margin-top: 1.5rem;
        }

        .nav-item {
            padding: 0.8rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .nav-item:hover, .nav-item.active {
            background: rgba(255, 255, 255, 0.1);
            border-left: 3px solid var(--accent);
        }

        .nav-item i {
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            padding: 1.5rem;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            font-size: 1.8rem;
            color: var(--dark);
        }

        .search-bar {
            display: flex;
            align-items: center;
            background: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            width: 300px;
        }

        .search-bar input {
            border: none;
            outline: none;
            padding: 0.5rem;
            width: 100%;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .stat-icon.primary {
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }

        .stat-icon.success {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .stat-icon.warning {
            background: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .stat-info h3 {
            font-size: 1.8rem;
            margin-bottom: 0.2rem;
        }

        .stat-info p {
            color: #666;
            font-size: 0.9rem;
        }

        .recent-orders {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background: #f9f9f9;
            font-weight: 500;
            color: #555;
        }

        tr:hover {
            background: #f5f7ff;
        }

        .status {
            padding: 0.3rem 0.6rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status.completed {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .status.pending {
            background: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .recent-books {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .book-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
        }

        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            height: 150px;
            background-size: cover;
            background-position: center;
        }

        .book-info {
            padding: 1rem;
        }

        .book-title {
            font-weight: 500;
            margin-bottom: 0.3rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .book-author {
            color: #666;
            font-size: 0.8rem;
            margin-bottom: 0.5rem;
        }

        .book-actions {
            display: flex;
            justify-content: space-between;
        }

        .btn-sm {
            padding: 0.3rem 0.6rem;
            font-size: 0.8rem;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background: var(--primary);
            color: white;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }

            .search-bar {
                width: 100%;
                margin-top: 1rem;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="user-profile">
            <img src="https://ui-avatars.com/api/?name=John+Doe&background=random" alt="User" class="user-avatar">
            <h3 class="user-name">John Doe</h3>
            <p class="user-email">john.doe@example.com</p>
        </div>

        <div class="nav-menu">
            <div class="nav-item active">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-book"></i>
                <span>My Library</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-shopping-cart"></i>
                <span>My Cart</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-receipt"></i>
                <span>Orders</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-heart"></i>
                <span>Wishlist</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </div>
            <div class="nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1 class="page-title">Dashboard</h1>
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search books...">
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-icon primary">
                    <i class="fas fa-book-open"></i>
                </div>
                <div class="stat-info">
                    <h3>42</h3>
                    <p>Books in Library</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>18</h3>
                    <p>Completed Orders</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon warning">
                    <i class="fas fa-spinner"></i>
                </div>
                <div class="stat-info">
                    <h3>3</h3>
                    <p>Pending Orders</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon primary">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="stat-info">
                    <h3>7</h3>
                    <p>Wishlist Items</p>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="recent-orders">
            <h2 class="section-title">
                Recent Orders
                <button class="btn btn-primary">View All</button>
            </h2>

            <table>
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Book Title</th>
                    <th>Date</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#EBK-1254</td>
                    <td>Atomic Habits</td>
                    <td>May 15, 2023</td>
                    <td>$12.99</td>
                    <td><span class="status completed">Completed</span></td>
                    <td><button class="btn btn-sm btn-outline">Download</button></td>
                </tr>
                <tr>
                    <td>#EBK-1253</td>
                    <td>The Psychology of Money</td>
                    <td>May 10, 2023</td>
                    <td>$10.50</td>
                    <td><span class="status completed">Completed</span></td>
                    <td><button class="btn btn-sm btn-outline">Download</button></td>
                </tr>
                <tr>
                    <td>#EBK-1252</td>
                    <td>Deep Work</td>
                    <td>May 5, 2023</td>
                    <td>$9.99</td>
                    <td><span class="status pending">Processing</span></td>
                    <td><button class="btn btn-sm btn-outline" disabled>Download</button></td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- Recommended Books -->
        <div class="recent-orders">
            <h2 class="section-title">
                Recommended For You
                <button class="btn btn-primary">Browse More</button>
            </h2>

            <div class="recent-books">
                <div class="book-card">
                    <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/71X1p4TGlxL._AC_UF1000,1000_QL80_.jpg');"></div>
                    <div class="book-info">
                        <h3 class="book-title">Atomic Habits</h3>
                        <p class="book-author">James Clear</p>
                        <div class="book-actions">
                            <span class="book-price">$12.99</span>
                            <button class="btn btn-sm btn-primary">Add to Cart</button>
                        </div>
                    </div>
                </div>
                <div class="book-card">
                    <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/91n7pp7XsqL._AC_UF1000,1000_QL80_.jpg');"></div>
                    <div class="book-info">
                        <h3 class="book-title">The Psychology of Money</h3>
                        <p class="book-author">Morgan Housel</p>
                        <div class="book-actions">
                            <span class="book-price">$10.50</span>
                            <button class="btn btn-sm btn-primary">Add to Cart</button>
                        </div>
                    </div>
                </div>
                <div class="book-card">
                    <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/81dQwQlmAXL._AC_UF1000,1000_QL80_.jpg');"></div>
                    <div class="book-info">
                        <h3 class="book-title">Deep Work</h3>
                        <p class="book-author">Cal Newport</p>
                        <div class="book-actions">
                            <span class="book-price">$9.99</span>
                            <button class="btn btn-sm btn-primary">Add to Cart</button>
                        </div>
                    </div>
                </div>
                <div class="book-card">
                    <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/81WZ6QvGZ2L._AC_UF1000,1000_QL80_.jpg');"></div>
                    <div class="book-info">
                        <h3 class="book-title">1984</h3>
                        <p class="book-author">George Orwell</p>
                        <div class="book-actions">
                            <span class="book-price">$7.25</span>
                            <button class="btn btn-sm btn-primary">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Simple navigation active state
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelector('.nav-item.active').classList.remove('active');
            this.classList.add('active');
        });
    });
</script>
</body>
</html>