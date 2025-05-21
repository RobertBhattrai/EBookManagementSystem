<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Book Haven | Digital Reading Marketplace</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #5a75f5;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --dark: #1b263b;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --text: #2b2d42;
            --text-light: #8d99ae;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--text);
            line-height: 1.6;
            overflow-x: hidden;
        }

        header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1rem 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
            animation: fadeInDown 0.8s ease-out;
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
            letter-spacing: -0.5px;
        }

        .logo i {
            margin-right: 0.5rem;
            color: var(--accent);
            font-size: 2rem;
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
            position: relative;
        }

        .nav-links a:hover {
            color: var(--accent);
            transform: translateY(-2px);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 0;
            background-color: var(--accent);
            transition: width 0.3s;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 80vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
            padding: 0 1rem;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, transparent 0%, rgba(0,0,0,0.5) 100%);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            animation: fadeInUp 1s ease-out 0.3s both;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1.5rem;
            line-height: 1.2;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .hero p {
            font-size: 1.3rem;
            max-width: 700px;
            margin: 0 auto 2.5rem;
            text-shadow: 0 1px 2px rgba(0,0,0,0.3);
            opacity: 0.9;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: 1rem 2.2rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            cursor: pointer;
            text-align: center;
            font-size: 1.1rem;
            border: none;
        }

        .btn-primary {
            background-color: var(--accent);
            color: white;
            box-shadow: 0 4px 15px rgba(72, 149, 239, 0.4);
        }

        .btn-primary:hover {
            background-color: var(--primary-light);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(72, 149, 239, 0.6);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline:hover {
            background: white;
            color: var(--primary);
            transform: translateY(-3px);
        }

        .features {
            padding: 6rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-title h2 {
            font-size: 2.8rem;
            color: var(--dark);
            margin-bottom: 1.5rem;
            position: relative;
            display: inline-block;
        }

        .section-title h2::after {
            content: '';
            position: absolute;
            width: 60px;
            height: 4px;
            background: var(--accent);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .section-title p {
            color: var(--text-light);
            max-width: 700px;
            margin: 0 auto;
            font-size: 1.1rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2.5rem;
        }

        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: all 0.4s;
            text-align: center;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out forwards;
        }

        .feature-card:nth-child(1) {
            animation-delay: 0.2s;
        }
        .feature-card:nth-child(2) {
            animation-delay: 0.4s;
        }
        .feature-card:nth-child(3) {
            animation-delay: 0.6s;
        }
        .feature-card:nth-child(4) {
            animation-delay: 0.8s;
        }

        .feature-card:hover {
            transform: translateY(-10px) !important;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            font-size: 3rem;
            color: var(--accent);
            margin-bottom: 2rem;
            transition: transform 0.3s;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1);
        }

        .feature-card h3 {
            margin-bottom: 1.5rem;
            color: var(--dark);
            font-size: 1.5rem;
        }

        .feature-card p {
            color: var(--text-light);
            font-size: 1rem;
            line-height: 1.7;
        }

        .features {
            background-color: var(--light);
            padding: 6rem 2rem;
        }

        footer {
            background-color: var(--dark);
            color: white;
            padding: 4rem 2rem 2rem;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 3rem;
            text-align: left;
        }

        .footer-column h3 {
            margin-bottom: 1.8rem;
            font-size: 1.3rem;
            position: relative;
            display: inline-block;
        }

        .footer-column h3::after {
            content: '';
            position: absolute;
            width: 40px;
            height: 3px;
            background: var(--accent);
            bottom: -8px;
            left: 0;
            border-radius: 2px;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column ul li {
            margin-bottom: 1rem;
        }

        .footer-column ul li a {
            color: #ccc;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
        }

        .footer-column ul li a:hover {
            color: var(--accent);
            transform: translateX(5px);
        }

        .footer-column p {
            color: #ccc;
            line-height: 1.7;
            margin-bottom: 1.5rem;
        }

        .social-links {
            display: flex;
            gap: 1.2rem;
            margin-top: 1.5rem;
        }

        .social-links a {
            color: white;
            font-size: 1.3rem;
            transition: all 0.3s;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .social-links a:hover {
            color: white;
            background: var(--accent);
            transform: translateY(-3px);
        }

        .copyright {
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #aaa;
            font-size: 0.9rem;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        .pulse {
            animation: pulse 2s infinite;
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
                flex-wrap: wrap;
            }

            .hero {
                height: 70vh;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
            }

            .section-title h2 {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 2rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .btn {
                padding: 0.8rem 1.5rem;
                font-size: 1rem;
            }

            .section-title h2 {
                font-size: 1.8rem;
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
            <a href="${pageContext.request.contextPath}/LoginServlet"><i class="fas fa-shopping-cart"></i> Cart</a>
            <a href="${pageContext.request.contextPath}/LoginServlet"><i class="fas fa-tags"></i> New Arrivals</a>
            <a href="${pageContext.request.contextPath}/LoginServlet"><i class="fas fa-book"></i> Old Books</a>
        </div>
    </nav>
</header>

<section class="hero">
    <div class="hero-content">
        <h1>Discover Your Next Favorite Book</h1>
        <p>Explore thousands of e-books across all genres. Instant access, lifetime ownership, and the best prices guaranteed.</p>
        <div class="hero-buttons">
            <a href="#" class="btn btn-primary pulse">Browse Collection</a>
            <a href="${pageContext.request.contextPath}/RegisterServlet" class="btn btn-outline">Join Free</a>
        </div>
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
            <h3>Order From Anywhere</h3>
            <p>Geographical reason should never stop you from reading.</p>
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
                <i class="fas fa-cart-plus"></i>
            </div>
            <h3>4. Deliver at Home</h3>
            <p>Get your books delivery instantly in your desired location.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">
                <i class="fas fa-book-reader"></i>
            </div>
            <h3>5. Read & Enjoy</h3>
            <p>Read your book.</p>
        </div>
    </div>
</section>

<footer>
    <div class="footer-content">
        <div class="footer-column">
            <h3>E-Book Haven</h3>
            <p>Your premier destination for reading. We offer the best selection of books at competitive prices.</p>
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
                <li><i class="fas fa-map-marker-alt"></i> Sundar Harincha-4, Morang</li>
                <li><i class="fas fa-phone"></i> +977 98-453920</li>
                <li><i class="fas fa-envelope"></i> support@ebookhaven.com</li>
            </ul>
        </div>
    </div>
    <div class="copyright">
        <p>&copy; 2023 E-Book Haven. All rights reserved.</p>
    </div>
</footer>

<script>
    // One-time animation observer
    const animateOnScroll = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = 1;
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    };

    const observer = new IntersectionObserver(animateOnScroll, {
        threshold: 0.1
    });

    document.querySelectorAll('.feature-card').forEach(card => {
        observer.observe(card);
    });

    // Add hover effect to feature cards
    document.querySelectorAll('.feature-card').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-10px)';
            card.style.boxShadow = '0 15px 40px rgba(0, 0, 0, 0.1)';
        });

        card.addEventListener('mouseleave', () => {
            if (!card.classList.contains('animated')) {
                card.style.transform = 'translateY(0)';
                card.style.boxShadow = '0 10px 30px rgba(0, 0, 0, 0.05)';
            }
        });
    });
</script>
</body>
</html>