<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | E-Book Haven</title>
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
            --sidebar-width: 250px;
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
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--dark);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            transition: all 0.3s;
        }

        .brand {
            text-align: center;
            padding: 0 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .brand-logo {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .brand-title {
            font-size: 1.2rem;
            font-weight: 600;
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
            flex: 1;
            margin-left: var(--sidebar-width);
            transition: all 0.3s;
        }

        .topbar {
            background: white;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .toggle-sidebar {
            font-size: 1.2rem;
            cursor: pointer;
            color: var(--dark);
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent);
        }

        .content-area {
            padding: 1.5rem;
        }

        .page-title {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: var(--dark);
        }

        /* Dashboard Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
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

        .stat-icon.danger {
            background: rgba(247, 37, 133, 0.1);
            color: var(--danger);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        /* Tables */
        .card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 600;
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

        .status.success {
            background: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .status.warning {
            background: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .status.danger {
            background: rgba(247, 37, 133, 0.1);
            color: var(--danger);
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .btn-sm {
            padding: 0.3rem 0.6rem;
            font-size: 0.8rem;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #d11a5b;
            transform: translateY(-2px);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #3ab4d8;
            transform: translateY(-2px);
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="number"],
        select, textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                left: -100%;
            }
            .sidebar.active {
                left: 0;
            }
            .main-content {
                margin-left: 0;
            }
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            border-radius: 10px;
            width: 90%;
            max-width: 600px;
            padding: 1.5rem;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-title {
            font-size: 1.3rem;
            font-weight: 600;
        }

        .close-modal {
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }
    </style>
</head>
<body>
<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="brand">
        <div class="brand-logo">
            <i class="fas fa-book-open"></i>
        </div>
        <div class="brand-title">E-Book Haven</div>
    </div>

    <div class="nav-menu">
        <div class="nav-item active">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </div>
        <div class="nav-item">
            <i class="fas fa-book"></i>
            <span>Manage Books</span>
        </div>
        <div class="nav-item">
            <i class="fas fa-users"></i>
            <span>Manage Users</span>
        </div>
        <div class="nav-item">
            <i class="fas fa-shopping-cart"></i>
            <span>Orders</span>
        </div>
        <div class="nav-item">
            <i class="fas fa-chart-line"></i>
            <span>Reports</span>
        </div>
        <div class="nav-item">
            <i class="fas fa-tags"></i>
            <span>Categories</span>
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
    <!-- Topbar -->
    <div class="topbar">
        <div class="toggle-sidebar" id="toggleSidebar">
            <i class="fas fa-bars"></i>
        </div>
        <div class="user-menu">
            <div class="user-info">
                <div class="user-name">Admin User</div>
                <div class="user-role">Administrator</div>
            </div>
            <img src="https://ui-avatars.com/api/?name=Admin+User&background=random" alt="Admin" class="user-avatar">
        </div>
    </div>

    <!-- Content Area -->
    <div class="content-area">
        <h1 class="page-title">Admin Dashboard</h1>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">1,254</div>
                        <div class="stat-label">Total Books</div>
                    </div>
                    <div class="stat-icon primary">
                        <i class="fas fa-book"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">568</div>
                        <div class="stat-label">Total Users</div>
                    </div>
                    <div class="stat-icon success">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">$12,458</div>
                        <div class="stat-label">Total Revenue</div>
                    </div>
                    <div class="stat-icon warning">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">24</div>
                        <div class="stat-label">Pending Orders</div>
                    </div>
                    <div class="stat-icon danger">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Orders -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Recent Orders</h2>
                <button class="btn btn-primary">View All</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#EBK-1254</td>
                    <td>John Doe</td>
                    <td>May 15, 2023</td>
                    <td>$42.97</td>
                    <td><span class="status success">Completed</span></td>
                    <td>
                        <button class="btn btn-sm btn-primary">View</button>
                    </td>
                </tr>
                <tr>
                    <td>#EBK-1253</td>
                    <td>Jane Smith</td>
                    <td>May 14, 2023</td>
                    <td>$29.99</td>
                    <td><span class="status warning">Processing</span></td>
                    <td>
                        <button class="btn btn-sm btn-primary">View</button>
                    </td>
                </tr>
                <tr>
                    <td>#EBK-1252</td>
                    <td>Robert Johnson</td>
                    <td>May 13, 2023</td>
                    <td>$15.99</td>
                    <td><span class="status danger">Cancelled</span></td>
                    <td>
                        <button class="btn btn-sm btn-primary">View</button>
                    </td>
                </tr>
                <tr>
                    <td>#EBK-1251</td>
                    <td>Sarah Williams</td>
                    <td>May 12, 2023</td>
                    <td>$56.50</td>
                    <td><span class="status success">Completed</span></td>
                    <td>
                        <button class="btn btn-sm btn-primary">View</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- Recent Books Added -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Recently Added Books</h2>
                <button class="btn btn-primary" id="addBookBtn">Add New Book</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>#B001</td>
                    <td>Atomic Habits</td>
                    <td>James Clear</td>
                    <td>Self-Help</td>
                    <td>$12.99</td>
                    <td>42</td>
                    <td>
                        <button class="btn btn-sm btn-primary">Edit</button>
                        <button class="btn btn-sm btn-danger">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td>#B002</td>
                    <td>The Psychology of Money</td>
                    <td>Morgan Housel</td>
                    <td>Finance</td>
                    <td>$10.50</td>
                    <td>35</td>
                    <td>
                        <button class="btn btn-sm btn-primary">Edit</button>
                        <button class="btn btn-sm btn-danger">Delete</button>
                    </td>
                </tr>
                <tr>
                    <td>#B003</td>
                    <td>Deep Work</td>
                    <td>Cal Newport</td>
                    <td>Productivity</td>
                    <td>$9.99</td>
                    <td>28</td>
                    <td>
                        <button class="btn btn-sm btn-primary">Edit</button>
                        <button class="btn btn-sm btn-danger">Delete</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Book Modal -->
<div class="modal" id="addBookModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Add New Book</h2>
            <span class="close-modal">&times;</span>
        </div>
        <form id="bookForm">
            <div class="form-group">
                <label for="bookTitle">Book Title</label>
                <input type="text" id="bookTitle" required>
            </div>
            <div class="form-group">
                <label for="bookAuthor">Author</label>
                <input type="text" id="bookAuthor" required>
            </div>
            <div class="form-group">
                <label for="bookCategory">Category</label>
                <select id="bookCategory" required>
                    <option value="">Select Category</option>
                    <option value="fiction">Fiction</option>
                    <option value="non-fiction">Non-Fiction</option>
                    <option value="self-help">Self-Help</option>
                    <option value="business">Business</option>
                </select>
            </div>
            <div class="form-group">
                <label for="bookPrice">Price ($)</label>
                <input type="number" id="bookPrice" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="bookStock">Stock Quantity</label>
                <input type="number" id="bookStock" required>
            </div>
            <div class="form-group">
                <label for="bookDescription">Description</label>
                <textarea id="bookDescription" rows="4"></textarea>
            </div>
            <div class="form-group">
                <label for="bookCover">Cover Image</label>
                <input type="file" id="bookCover" accept="image/*">
            </div>
            <button type="submit" class="btn btn-success">Add Book</button>
        </form>
    </div>
</div>

<script>
    // Toggle sidebar on mobile
    document.getElementById('toggleSidebar').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // Add Book Modal
    const addBookBtn = document.getElementById('addBookBtn');
    const addBookModal = document.getElementById('addBookModal');
    const closeModal = document.querySelector('.close-modal');

    addBookBtn.addEventListener('click', function() {
        addBookModal.style.display = 'flex';
    });

    closeModal.addEventListener('click', function() {
        addBookModal.style.display = 'none';
    });

    // Close modal when clicking outside
    window.addEventListener('click', function(e) {
        if (e.target === addBookModal) {
            addBookModal.style.display = 'none';
        }
    });

    // Form submission
    document.getElementById('bookForm').addEventListener('submit', function(e) {
        e.preventDefault();
        // Here you would handle the form submission via AJAX
        alert('Book added successfully!');
        addBookModal.style.display = 'none';
        this.reset();
    });

    // Set active nav item
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelector('.nav-item.active').classList.remove('active');
            this.classList.add('active');
        });
    });
</script>
</body>
</html>