<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - E-Book Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4a6fa5;
            --primary-dark: #3a5a80;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
            --gray-light: #e9ecef;
            --gray-medium: #ced4da;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --success-color: #28a745;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-color);
            color: var(--dark-color);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-image: linear-gradient(rgba(255,255,255,0.95), rgba(255,255,255,0.95)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .register-container {
            width: 100%;
            max-width: 600px;
            margin: 2rem auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .register-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            text-align: center;
            padding: 2rem;
        }

        .register-header i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            display: block;
        }

        .register-header h2 {
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .register-body {
            padding: 2rem;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 5px;
            font-size: 0.9rem;
            background-color: #f8d7da;
            color: var(--danger-color);
            border: 1px solid #f5c6cb;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        .required:after {
            content: " *";
            color: var(--danger-color);
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid var(--gray-medium);
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(79, 195, 247, 0.2);
        }

        .checkbox-group {
            margin-top: 0.5rem;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .checkbox-item input {
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
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .password-strength {
            height: 5px;
            margin-top: 0.5rem;
            background: var(--gray-light);
            border-radius: 3px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s;
        }

        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--gray-light);
        }

        .form-footer a {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .invalid-feedback {
            color: var(--danger-color);
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }

        .is-invalid {
            border-color: var(--danger-color) !important;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .register-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="register-container">
        <div class="register-header">
            <i class="fas fa-book-open"></i>
            <h2>Create Your Account</h2>
            <p>Join our E-Book community today</p>
        </div>

        <div class="register-body">
            <!-- Show error if any - using scriptlet instead of JSTL -->
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="RegisterServlet" method="post" id="registerForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName" class="required">First Name</label>
                        <input type="text" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="required">Last Name</label>
                        <input type="text" id="lastName" name="lastName" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email" class="required">Email Address</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="username" class="required">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" name="phone">
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address">
                </div>

                <div class="form-group">
                    <label for="role" class="required">Role</label>
                    <select id="role" name="role" required>
                        <option value="">Select a role</option>
                        <option value="user">User</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="password" class="required">Password</label>
                    <input type="password" id="password" name="password" required oninput="checkPasswordStrength(this.value)">
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <small>Minimum 8 characters with at least one number and special character</small>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="required">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                    <div id="passwordMatch" class="invalid-feedback"></div>
                </div>

                <div class="form-group">
                    <label>Reading Preferences (Optional)</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="fiction" name="preferences" value="Fiction">
                            <label for="fiction">Fiction</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="nonfiction" name="preferences" value="Non-Fiction">
                            <label for="nonfiction">Non-Fiction</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="scifi" name="preferences" value="Sci-Fi">
                            <label for="scifi">Science Fiction</label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Register
                    </button>
                </div>
            </form>

            <div class="form-footer">
                <p>Already have an account? <a href="LoginServlet">Sign in here</a></p>
            </div>
        </div>
    </div>
</div>

<script>
    // Password strength indicator
    function checkPasswordStrength(password) {
        const strengthBar = document.getElementById('passwordStrengthBar');
        let strength = 0;

        if (password.length >= 8) strength += 1;
        if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1;
        if (password.match(/([0-9])/)) strength += 1;
        if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;

        // Update strength bar
        const width = strength * 25;
        strengthBar.style.width = width + '%';

        // Change color
        if (strength < 2) {
            strengthBar.style.backgroundColor = 'var(--danger-color)';
        } else if (strength === 2) {
            strengthBar.style.backgroundColor = 'var(--warning-color)';
        } else if (strength === 3) {
            strengthBar.style.backgroundColor = 'var(--warning-color)';
        } else {
            strengthBar.style.backgroundColor = 'var(--success-color)';
        }
    }

    // Confirm password validation
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;
        const feedback = document.getElementById('passwordMatch');

        if (password !== confirmPassword && confirmPassword.length > 0) {
            this.classList.add('is-invalid');
            feedback.textContent = 'Passwords do not match';
        } else {
            this.classList.remove('is-invalid');
            feedback.textContent = '';
        }
    });
</script>
</body>
</html>