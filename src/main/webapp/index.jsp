<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Book Haven | Digital Reading Marketplace</title>
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
            line-height: 1.6;
        }

        header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .logo i {
            margin-right: 0.5rem;
            color: var(--accent);
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .nav-links a:hover {
            color: var(--accent);
            transform: translateY(-2px);
        }

        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 60vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 0 1rem;
        }

        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 700px;
            margin-bottom: 2rem;
        }

        .btn {
            display: inline-block;
            padding: 0.8rem 1.8rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-primary {
            background-color: var(--accent);
            color: white;
            box-shadow: 0 4px 15px rgba(72, 149, 239, 0.4);
        }

        .btn-primary:hover {
            background-color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(72, 149, 239, 0.6);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
            margin-left: 1rem;
        }

        .btn-outline:hover {
            background: white;
            color: var(--primary);
        }

        .features {
            padding: 5rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2.5rem;
            color: var(--dark);
            margin-bottom: 1rem;
        }

        .section-title p {
            color: #666;
            max-width: 700px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            text-align: center;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
        }

        .feature-card h3 {
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .book-categories {
            background-color: var(--light);
            padding: 5rem 2rem;
        }

        .category-tabs {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 3rem;
            flex-wrap: wrap;
        }

        .category-tab {
            padding: 0.8rem 1.5rem;
            background: white;
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .category-tab.active {
            background: var(--primary);
            color: white;
        }

        .category-tab:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
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
            height: 300px;
            background-color: #eee;
            background-size: cover;
            background-position: center;
        }

        .book-info {
            padding: 1.5rem;
        }

        .book-info h3 {
            margin-bottom: 0.5rem;
        }

        .book-author {
            color: #666;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .book-price {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            display: block;
        }

        .book-actions {
            display: flex;
            justify-content: space-between;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        .btn-cart {
            background-color: var(--success);
            color: white;
        }

        .btn-buy {
            background-color: var(--primary);
            color: white;
        }

        footer {
            background-color: var(--dark);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            text-align: left;
        }

        .footer-column h3 {
            margin-bottom: 1.5rem;
            font-size: 1.2rem;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 0.8rem;
        }

        .footer-column ul li a {
            color: #ccc;
            text-decoration: none;
            transition: all 0.3s;
        }

        .footer-column ul li a:hover {
            color: var(--accent);
            padding-left: 5px;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            color: white;
            font-size: 1.2rem;
            transition: all 0.3s;
        }

        .social-links a:hover {
            color: var(--accent);
            transform: translateY(-3px);
        }

        .copyright {
            margin-top: 3rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-links {
                width: 100%;
                justify-content: space-around;
            }

            .hero h1 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar">
        <div class="logo">
            <i class="fas fa-book-open"></i>
            <span>E-Book Haven</span>
        </div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/LoginServlet"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="#"><i class="fas fa-shopping-cart"></i> Cart</a>
            <a href="#"><i class="fas fa-tags"></i> New Arrivals</a>
            <a href="#"><i class="fas fa-book"></i> Old Books</a>
            <a href="${pageContext.request.contextPath}/AdminServlet"><i class="fas fa-user-shield"></i> Admin</a>
        </div>
    </nav>
</header>

<section class="hero">
    <h1>Discover Your Next Favorite Book</h1>
    <p>Explore thousands of e-books across all genres. Instant access, lifetime ownership, and the best prices guaranteed.</p>
    <div>
        <a href="#" class="btn btn-primary">Browse Collection</a>
        <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-outline">Join Free</a>
    </div>
</section>

<section class="features">
    <div class="section-title">
        <h2>Why Choose E-Book Haven?</h2>
        <p>We provide the best digital reading experience with features designed for book lovers</p>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-bolt"></i>
            </div>
            <h3>Instant Delivery</h3>
            <p>Get your books immediately after purchase with our lightning-fast delivery system.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-mobile-alt"></i>
            </div>
            <h3>Read Anywhere</h3>
            <p>Access your library on any device - phone, tablet, or computer.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-hand-holding-usd"></i>
            </div>
            <h3>Cash on Delivery</h3>
            <p>We offer COD for physical book purchases with no extra charges.</p>
        </div>
    </div>
</section>

<section class="book-categories">
    <div class="section-title">
        <h2>Popular Categories</h2>
        <p>Browse through our extensive collection of books in various categories</p>
    </div>
    <div class="category-tabs">
        <div class="category-tab active">All Books</div>
        <div class="category-tab">New Releases</div>
        <div class="category-tab">Old Editions</div>
        <div class="category-tab">Best Sellers</div>
        <div class="category-tab">Textbooks</div>
        <div class="category-tab">Fiction</div>
    </div>
    <div class="books-grid">
        <div class="book-card">
            <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/71X1p4TGlxL._AC_UF1000,1000_QL80_.jpg');"></div>
            <div class="book-info">
                <h3>Atomic Habits</h3>
                <p class="book-author">James Clear</p>
                <span class="book-price">$12.99</span>
                <div class="book-actions">
                    <a href="#" class="btn btn-sm btn-cart"><i class="fas fa-cart-plus"></i> Add</a>
                    <a href="#" class="btn btn-sm btn-buy"><i class="fas fa-wallet"></i> Buy</a>
                </div>
            </div>
        </div>
        <div class="book-card">
            <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/91n7pp7XsqL._AC_UF1000,1000_QL80_.jpg');"></div>
            <div class="book-info">
                <h3>The Psychology of Money</h3>
                <p class="book-author">Morgan Housel</p>
                <span class="book-price">$10.50</span>
                <div class="book-actions">
                    <a href="#" class="btn btn-sm btn-cart"><i class="fas fa-cart-plus"></i> Add</a>
                    <a href="#" class="btn btn-sm btn-buy"><i class="fas fa-wallet"></i> Buy</a>
                </div>
            </div>
        </div>
        <div class="book-card">
            <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/81dQwQlmAXL._AC_UF1000,1000_QL80_.jpg');"></div>
            <div class="book-info">
                <h3>Deep Work</h3>
                <p class="book-author">Cal Newport</p>
                <span class="book-price">$9.99</span>
                <div class="book-actions">
                    <a href="#" class="btn btn-sm btn-cart"><i class="fas fa-cart-plus"></i> Add</a>
                    <a href="#" class="btn btn-sm btn-buy"><i class="fas fa-wallet"></i> Buy</a>
                </div>
            </div>
        </div>
        <div class="book-card">
            <div class="book-cover" style="background-image: url('https://m.media-amazon.com/images/I/81WZ6QvGZ2L._AC_UF1000,1000_QL80_.jpg');"></div>
            <div class="book-info">
                <h3>1984 (Old Edition)</h3>
                <p class="book-author">George Orwell</p>
                <span class="book-price">$7.25</span>
                <div class="book-actions">
                    <a href="#" class="btn btn-sm btn-cart"><i class="fas fa-cart-plus"></i> Add</a>
                    <a href="#" class="btn btn-sm btn-buy"><i class="fas fa-wallet"></i> Buy</a>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="features">
    <div class="section-title">
        <h2>How It Works</h2>
        <p>Get your favorite books in just a few simple steps</p>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-search"></i>
            </div>
            <h3>1. Browse & Search</h3>
            <p>Find your desired book using our powerful search and filtering tools.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-cart-plus"></i>
            </div>
            <h3>2. Add to Cart</h3>
            <p>Select books and add them to your shopping cart.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-credit-card"></i>
            </div>
            <h3>3. Checkout</h3>
            <p>Choose payment method (Credit Card, PayPal, or COD) and complete your order.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-book-reader"></i>
            </div>
            <h3>4. Read & Enjoy</h3>
            <p>Access your books instantly in your personal library.</p>
        </div>
    </div>
</section>

<footer>
    <div class="footer-content">
        <div class="footer-column">
            <h3>E-Book Haven</h3>
            <p>Your premier destination for digital reading. We offer the best selection of e-books at competitive prices.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        <div class="footer-column">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/LoginServlet">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/RegisterServlet">Register</a></li>
                <li><a href="#">My Cart</a></li>
                <li><a href="#">My Orders</a></li>
                <li><a href="${pageContext.request.contextPath}/AdminServlet">Admin Panel</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Categories</h3>
            <ul>
                <li><a href="#">New Arrivals</a></li>
                <li><a href="#">Old Books</a></li>
                <li><a href="#">Textbooks</a></li>
                <li><a href="#">Fiction</a></li>
                <li><a href="#">Non-Fiction</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Contact Us</h3>
            <ul>
                <li><i class="fas fa-map-marker-alt"></i> 123 Book Street, Knowledge City</li>
                <li><i class="fas fa-phone"></i> +1 (555) 123-4567</li>
                <li><i class="fas fa-envelope"></i> support@ebookhaven.com</li>
            </ul>
        </div>
    </div>
    <div class="copyright">
        <p>&copy; 2023 E-Book Haven. All rights reserved.</p>
    </div>
</footer>

<script>
    // Simple category tab functionality
    document.querySelectorAll('.category-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelector('.category-tab.active').classList.remove('active');
            tab.classList.add('active');
            // Here you would typically load books for this category via AJAX
        });
    });
</script>
</body>
</html>