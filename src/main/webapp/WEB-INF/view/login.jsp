<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | E-Book Haven</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            text-align: center;
            padding: 2rem;
        }

        .login-header i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .login-header h2 {
            margin-bottom: 0.5rem;
        }

        .login-body {
            padding: 2rem;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark);
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .remember-me input {
            margin-right: 0.5rem;
        }

        .btn {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
        }

        .login-footer a {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
        }

        .login-footer a:hover {
            text-decoration: underline;
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
            color: #666;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
            }

            .login-header {
                padding: 1.5rem;
            }

            .login-body {
                padding: 1.5rem;
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
            <%= request.getAttribute("registrationSuccess") %>
        </div>
        <% } %>

        <!-- Display error message if login fails -->
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="form-group password-toggle">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
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
            <p>Don't have an account? <a href="RegisterServlet">Register here</a></p>
            <p><a href="#">Forgot your password?</a></p>
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
        this.classList.toggle('fa-eye-slash');
    });

    // Auto-fill username if available in cookie
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