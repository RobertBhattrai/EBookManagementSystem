<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | E-Book Haven</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/component/style.css">
    <style>
        body {
            background-color: var(--light);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(rgba(67, 97, 238, 0.8), rgba(63, 55, 201, 0.8)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-blend-mode: overlay;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 12px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transform: translateY(0);
            transition: var(--transition);
            animation: fadeInUp 0.8s ease-out;
        }

        .login-container:hover {
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            text-align: center;
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transform: rotate(30deg);
        }

        .login-header i {
            font-size: 3rem;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
            color: rgba(255,255,255,0.9);
        }

        .login-header h2 {
            margin-bottom: 0.5rem;
            font-size: 1.8rem;
            position: relative;
            z-index: 1;
        }

        .login-header p {
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .login-body {
            padding: 2.5rem;
        }

        .password-toggle {
            position: relative;
        }

        .password-toggle i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-light);
            transition: var(--transition);
        }

        .password-toggle i:hover {
            color: var(--primary);
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .remember-me input {
            margin-right: 0.5rem;
            accent-color: var(--primary);
        }

        .remember-me label {
            margin-bottom: 0;
            color: var(--text);
        }

        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .login-footer p {
            margin-bottom: 0.8rem;
            color: var(--text-light);
        }

        .login-footer a {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
        }

        .login-footer a:hover {
            color: var(--secondary);
            text-decoration: underline;
        }

        /* Responsive */
        @media (max-width: 576px) {
            .login-container {
                margin: 1.5rem;
            }

            .login-header {
                padding: 2rem;
            }

            .login-body {
                padding: 2rem;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <i class="fas fa-book-open"></i>
        <h2>Welcome Back</h2>
        <p>Sign in to access your E-Book collection</p>
    </div>

    <div class="login-body">
        <!-- Display registration success message if available -->
        <% if (request.getAttribute("registrationSuccess") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("registrationSuccess") %>
        </div>
        <% } %>

        <!-- Display error message if login fails -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" required placeholder="Enter your username or email">
            </div>

            <div class="form-group password-toggle">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
                <i class="fas fa-eye" id="togglePassword"></i>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <label for="rememberMe">Remember me</label>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>

        <div class="login-footer">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/RegisterServlet">Register here</a></p>
            <p><a href="">Forgot your password?</a></p>
        </div>
    </div>
</div>

<script>
    // Toggle password visibility
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');

    togglePassword.addEventListener('click', function() {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.classList.toggle('fa-eye');
        this.classList.toggle('fa-eye-slash');
    });

    // Autofill username if available in cookie
    document.addEventListener('DOMContentLoaded', function() {
        const cookies = document.cookie.split(';');
        for (let cookie of cookies) {
            cookie = cookie.trim();
            if (cookie.startsWith('rememberMe=')) {
                const value = cookie.substring('rememberMe='.length);
                try {
                    const decoded = atob(value);
                    const username = decoded.split(':')[0];
                    if (username) {
                        document.getElementById('username').value = username;
                        document.getElementById('rememberMe').checked = true;
                    }
                } catch (e) {
                    console.error('Error decoding cookie:', e);
                }
                break;
            }
        }
    });
</script>
</body>
</html>