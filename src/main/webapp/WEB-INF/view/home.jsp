<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.UserModel" %>
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
    <title>Home - E-Book Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/style.css">
    <style>
        body {
            background-color: var(--light);
            animation: fadeIn 0.8s ease-out;
        }

        .main-content {
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        /* Welcome Section */
        .welcome-section {
            text-align: center;
            margin-bottom: 3rem;
            padding: 3rem 2rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: rotate(30deg);
        }

        .welcome-content {
            position: relative;
            z-index: 2;
        }

        .welcome-section h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .welcome-section p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Features Section */
        .features-section {
            margin-top: 3rem;
        }

        .section-title {
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
        }

        .section-title h2 {
            font-size: 2rem;
            color: var(--dark);
            margin-bottom: 1rem;
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
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            text-align: center;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out forwards;
        }

        .feature-card:nth-child(1) { animation-delay: 0.2s; }
        .feature-card:nth-child(2) { animation-delay: 0.4s; }
        .feature-card:nth-child(3) { animation-delay: 0.6s; }

        .feature-card:hover {
            transform: translateY(-10px) !important;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 3rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1);
            color: var(--primary);
        }

        .feature-card h3 {
            margin-bottom: 1rem;
            color: var(--dark);
            font-size: 1.5rem;
        }

        .feature-card p {
            color: var(--text-light);
            line-height: 1.7;
        }

        /* Stats Section */
        .stats-section {
            margin: 4rem 0;
            background: linear-gradient(rgba(67, 97, 238, 0.9), rgba(63, 55, 201, 0.9)),
            url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            padding: 3rem 2rem;
            border-radius: var(--border-radius);
            color: white;
            text-align: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            max-width: 900px;
            margin: 0 auto;
        }

        .stat-item {
            padding: 1.5rem;
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.8s ease-out forwards;
        }

        .stat-item:nth-child(1) { animation-delay: 0.3s; }
        .stat-item:nth-child(2) { animation-delay: 0.5s; }
        .stat-item:nth-child(3) { animation-delay: 0.7s; }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .welcome-section {
                padding: 2rem 1.5rem;
            }

            .welcome-section h1 {
                font-size: 2rem;
            }

            .welcome-section p {
                font-size: 1rem;
            }

            .section-title h2 {
                font-size: 1.8rem;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 0 1rem;
            }

            .welcome-section {
                padding: 1.5rem 1rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<%@ include file="../component/navbar.jsp"%>

<!-- Main Content -->
<main class="main-content">
    <!-- Welcome, Section -->
    <section class="welcome-section">
        <div class="welcome-content">
            <h1>Welcome Back, <%= loggedInUser.getName() %>!</h1>
            <p>Discover your next favorite book from our extensive collection of e-books. Read anytime, anywhere.</p>
            <a href="BrowseBooksServlet" class="btn btn-primary pulse">
                <i class="fas fa-book-open"></i> Browse Collection
            </a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="section-title">
            <h2>Why Choose E-Book Haven?</h2>
            <p>We provide the best digital reading experience with features designed for book lovers</p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-book"></i>
                </div>
                <h3>Wide Selection</h3>
                <p>Explore thousands of books across various genres and categories, with new titles added weekly.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h3>Instant Access</h3>
                <p>Get immediate access to your purchases. Start reading seconds after completing your order.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-mobile-alt"></i>
                </div>
                <h3>Read Anywhere</h3>
                <p>Access your library on any device - phone, tablet, or computer. Your books are always with you.</p>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <h2 style="margin-bottom: 2rem;">Our Community</h2>
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">10,000+</div>
                <div class="stat-label">Happy Readers</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">50,000+</div>
                <div class="stat-label">Books Available</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Customer Support</div>
            </div>
        </div>
    </section>
</main>

<script>
    // Initialize animations on scroll
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

    document.querySelectorAll('.feature-card, .stat-item').forEach(item => {
        observer.observe(item);
    });
</script>
</body>
</html>