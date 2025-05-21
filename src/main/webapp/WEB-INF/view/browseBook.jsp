<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.BookModel" %>
<%@ page import="models.UserModel" %>
<%@ page import="java.util.List" %>
<%
    List<BookModel> books = (List<BookModel>) request.getAttribute("books");
    String searchQuery = request.getParameter("search") != null ? request.getParameter("search") : "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Books - E-Book Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/style.css">
    <style>
        body {
            background-color: var(--light);
        }

        .main-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-header h1 {
            font-size: 2.5rem;
            color: var(--dark);
            margin-bottom: 1rem;
            font-weight: 600;
            position: relative;
            display: inline-block;
        }

        .page-header h1::after {
            content: '';
            position: absolute;
            width: 80px;
            height: 4px;
            background: var(--accent);
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .page-header p {
            color: var(--text-light);
            font-size: 1.1rem;
            max-width: 700px;
            margin: 0 auto;
        }

        /* Search Bar */
        .search-container {
            max-width: 700px;
            margin: 0 auto 3rem;
            position: relative;
        }

        .search-form {
            display: flex;
            position: relative;
        }

        .search-input {
            flex: 1;
            padding: 1rem 1.5rem;
            border: 2px solid rgba(67, 97, 238, 0.2);
            border-radius: 50px;
            font-size: 1rem;
            transition: var(--transition);
            padding-right: 4rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(72, 149, 239, 0.2);
        }

        .search-button {
            position: absolute;
            right: 5px;
            top: 5px;
            bottom: 5px;
            width: 50px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-button:hover {
            background: var(--primary-light);
            transform: scale(1.05);
        }

        /* Filter Section */
        .filter-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .filter-label {
            font-weight: 500;
            color: var(--dark);
        }

        .filter-select {
            padding: 0.6rem 1rem;
            border: 2px solid rgba(67, 97, 238, 0.2);
            border-radius: 6px;
            font-size: 0.9rem;
            transition: var(--transition);
            cursor: pointer;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--accent);
        }

        .view-toggle {
            display: flex;
            gap: 0.5rem;
        }

        .view-btn {
            background: white;
            border: 2px solid rgba(67, 97, 238, 0.2);
            border-radius: 6px;
            padding: 0.5rem 1rem;
            cursor: pointer;
            transition: var(--transition);
        }

        .view-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .view-btn:hover {
            border-color: var(--accent);
        }

        /* Books Grid */
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .book-card {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            transition: var(--transition);
            opacity: 0;
            transform: translateY(30px);
        }

        .book-card:hover {
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .book-image-container {
            padding: 0.5rem;
            height: 220px;
            position: relative;
            overflow: hidden;
        }

        .book-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: var(--transition);
        }

        .book-card:hover .book-image {
            transform: scale(1.05);
        }

        .book-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--accent);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
            z-index: 1;
        }

        .book-details {
            padding: 1.5rem;
        }

        .book-title {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: var(--dark);
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .book-author {
            color: var(--text-light);
            margin-bottom: 0.8rem;
            font-size: 0.9rem;
        }

        .book-price {
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1.2rem;
            font-size: 1.2rem;
        }

        .book-actions {
            display: flex;
            justify-content: space-between;
            gap: 0.8rem;
        }

        .btn {
            flex: 1;
            padding: 0.7rem;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-details {
            background: white;
            border: 2px solid var(--primary);
            color: var(--primary);
        }

        .btn-details:hover {
            background: var(--primary-light);
            color: white;
            border-color: var(--primary-light);
        }

        .btn-cart {
            background: var(--primary);
            color: white;
            border: 2px solid var(--primary);
        }

        .btn-cart:hover {
            background: var(--primary-light);
            border-color: var(--primary-light);
            transform: translateY(-2px);
        }

        /* No Books Message */
        .no-books {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin: 2rem 0;
            animation: fadeInUp 0.8s ease-out;
        }

        .no-books i {
            font-size: 3rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
        }

        .no-books h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--dark);
        }

        .no-books p {
            color: var(--text-light);
            margin-bottom: 1.5rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .books-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-group {
                justify-content: space-between;
            }

            .page-header h1 {
                font-size: 2rem;
            }
        }

        @media (max-width: 576px) {
            .books-grid {
                grid-template-columns: 1fr;
            }

            .book-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .main-container {
                padding: 0 1rem;
            }

            .page-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
<%@include file="../component/navbar.jsp"%>

<!-- Main Content -->
<main class="main-container">
    <!-- Page Header -->
    <div class="page-header">
        <h1><i class="fas fa-book-open"></i> Browse Our Collection</h1>
        <p>Discover thousands of books across all genres. Find your next favorite read!</p>
    </div>

    <!-- Search Form -->
    <div class="search-container">
        <form action="BrowseBooksServlet" method="get" class="search-form">
            <input type="text" name="search" class="search-input"
                   placeholder="Search by title, author, or genre..."
                   value="<%= searchQuery %>">
            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <!-- Filter Section -->
    <div class="filter-section">
        <div class="filter-group">
            <span class="filter-label">Filter by:</span>
            <select class="filter-select" id="categoryFilter">
                <option value="all">All Categories</option>
                <option value="Fiction">Fiction</option>
                <option value="Non-Fiction">Non-Fiction</option>
                <option value="Science">Science</option>
                <option value="Technology">Technology</option>
                <option value="Biography">Biography</option>
            </select>
        </div>
        <div class="view-toggle">
            <button class="view-btn active"><i class="fas fa-th"></i></button>
            <button class="view-btn"><i class="fas fa-list"></i></button>
        </div>
    </div>

    <!-- Books Grid -->
    <% if (books != null && !books.isEmpty()) { %>
    <div class="books-grid">
        <% for (BookModel book : books) { %>
        <div class="book-card" data-category="<%= book.getCategory() != null ? book.getCategory() : "Uncategorized" %>">
            <div class="book-image-container">
                <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
                <img src="uploads/<%= book.getPhoto() %>" alt="<%= book.getBookName() %>" class="book-image">
                <% } else { %>
                <div style="height: 100%; background: linear-gradient(135deg, rgba(67,97,238,0.1), rgba(72,149,239,0.2));
                    display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-book" style="font-size: 3rem; color: var(--primary);"></i>
                </div>
                <% } %>
                <% if (book.getPrice() < 10) { %>
                <span class="book-badge">Sale</span>
                <% } %>
            </div>
            <div class="book-details">
                <h3 class="book-title"><%= book.getBookName() %></h3>
                <p class="book-author">By <%= book.getAuthor() %></p>
                <p class="book-price">₹<%= String.format("%.2f", book.getPrice()) %></p>
                <div class="book-actions">
                    <a href="BookDetailsServlet?id=<%= book.getBookId() %>" class="btn btn-details">
                        <i class="fas fa-info-circle"></i> Details
                    </a>
                    <a href="AddToCartServlet?id=<%= book.getBookId() %>" class="btn btn-cart">
                        <i class="fas fa-cart-plus"></i> Add
                    </a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <!-- No Books Message -->
    <div class="no-books">
        <i class="fas fa-book-open"></i>
        <h3>No Books Found</h3>
        <p>We couldn't find any books matching your search. Try adjusting your filters or search term.</p>
        <a href="BrowseBooksServlet" class="btn btn-cart" style="max-width: 250px; margin: 0 auto;">
            <i class="fas fa-sync-alt"></i> Reset Search
        </a>
    </div>
    <% } %>
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

    document.querySelectorAll('.book-card').forEach(card => {
        observer.observe(card);
    });

    // View toggle functionality
    const viewBtns = document.querySelectorAll('.view-btn');
    const booksGrid = document.querySelector('.books-grid');

    viewBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            viewBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            if (btn.querySelector('.fa-list')) {
                booksGrid.classList.add('list-view');
            } else {
                booksGrid.classList.remove('list-view');
            }
        });
    });

    // Category filter functionality
    document.getElementById('categoryFilter').addEventListener('change', function() {
        const selectedCategory = this.value;
        const bookCards = document.querySelectorAll('.book-card');
        let visibleCount = 0;

        bookCards.forEach(card => {
            const cardCategory = card.getAttribute('data-category');

            if (selectedCategory === 'all' || cardCategory === selectedCategory) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        // Show no books message if no cards are visible
        const noBooksMessage = document.querySelector('.no-books');
        if (visibleCount === 0 && !noBooksMessage) {
            // Create a temporary no books message if none exists
            const tempNoBooks = document.createElement('div');
            tempNoBooks.className = 'no-books';
            tempNoBooks.innerHTML = `
                <i class="fas fa-book-open"></i>
                <h3>No Books Found</h3>
                <p>No books match the selected category filter.</p>
                <button onclick="resetFilter()" class="btn btn-cart" style="max-width: 250px; margin: 0 auto;">
                    <i class="fas fa-sync-alt"></i> Reset Filter
                </button>
            `;
            booksGrid.parentNode.insertBefore(tempNoBooks, booksGrid.nextSibling);
        } else if (noBooksMessage && visibleCount > 0) {
            noBooksMessage.remove();
        }
    });

    function resetFilter() {
        document.getElementById('categoryFilter').value = 'all';
        document.querySelectorAll('.book-card').forEach(card => {
            card.style.display = 'block';
        });
        const tempNoBooks = document.querySelector('.no-books');
        if (tempNoBooks) {
            tempNoBooks.remove();
        }
    }
</script>
</body>
</html>