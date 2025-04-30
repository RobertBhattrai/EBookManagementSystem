<%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/30/2025
  Time: 8:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error Occurred</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --accent-color: #e74c3c;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-color);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .error-container {
            max-width: 600px;
            width: 100%;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .error-header {
            background-color: var(--accent-color);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .error-header i {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .error-header h1 {
            font-size: 1.8rem;
            margin-bottom: 5px;
        }

        .error-body {
            padding: 30px;
        }

        .error-details {
            background-color: #fde8e8;
            border-left: 4px solid var(--accent-color);
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .error-message {
            font-weight: 500;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .error-stack {
            font-family: monospace;
            font-size: 0.9rem;
            color: #666;
            white-space: pre-wrap;
            word-wrap: break-word;
        }

        .error-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: var(--dark-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: #1a252f;
        }

        .hidden {
            display: none;
        }

        .toggle-stack {
            color: var(--accent-color);
            cursor: pointer;
            font-size: 0.9rem;
            margin-top: 10px;
            display: inline-block;
        }

        @media (max-width: 480px) {
            .error-actions {
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-header">
        <i class="fas fa-exclamation-triangle"></i>
        <h1>Something Went Wrong</h1>
        <p>We encountered an error while processing your request</p>
    </div>

    <div class="error-body">
        <div class="error-details">
            <div class="error-message">
                <c:choose>
                    <%-- Check session first, then request --%>
                    <c:when test="${not empty sessionScope.errorMessage}">
                        ${sessionScope.errorMessage}
                        <%-- Clear the message after displaying --%>
                        <c:remove var="errorMessage" scope="session"/>
                    </c:when>
                    <c:when test="${not empty requestScope.errorMessage}">
                        ${requestScope.errorMessage}
                    </c:when>
                    <c:when test="${not empty pageContext.exception}">
                        ${pageContext.exception.message}
                    </c:when>
                    <c:otherwise>
                        An unexpected error occurred. Please try again later.
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty pageContext.exception}">
                <a id="toggleStack" class="toggle-stack">
                    <i class="fas fa-code"></i> Show technical details
                </a>
                <div id="stackTrace" class="error-stack hidden">
                    <strong>Exception:</strong> ${pageContext.exception.class.name}<br><br>
                    <strong>Stack Trace:</strong><br>
                    <c:forEach var="trace" items="${pageContext.exception.stackTrace}">
                        at ${trace}<br>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <p>We apologize for the inconvenience. Please try the following:</p>
        <ul style="margin-left: 20px; margin-bottom: 20px; color: #555;">
            <li>Refresh the page and try again</li>
            <li>Check if you have the correct permissions</li>
            <li>Contact support if the problem persists</li>
        </ul>

        <div class="error-actions">
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="fas fa-home"></i> Return Home
            </a>
        </div>
    </div>
</div>

<script>
    // Toggle stack trace visibility
    document.getElementById('toggleStack')?.addEventListener('click', function() {
        const stackTrace = document.getElementById('stackTrace');
        const toggleLink = document.getElementById('toggleStack');

        if (stackTrace.classList.contains('hidden')) {
            stackTrace.classList.remove('hidden');
            toggleLink.innerHTML = '<i class="fas fa-code"></i> Hide technical details';
        } else {
            stackTrace.classList.add('hidden');
            toggleLink.innerHTML = '<i class="fas fa-code"></i> Show technical details';
        }
    });
</script>
</body>
</html>
