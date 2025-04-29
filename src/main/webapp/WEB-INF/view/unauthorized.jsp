<%@ page import="models.UserModel" %><%--
  Created by IntelliJ IDEA.
  User: bhatt
  Date: 4/21/2025
  Time: 9:00 PM
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Unauthorized Access</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #d32f2f;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-top: 20px;
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Unauthorized Access</h1>
    <p>You don't have permission to access this page.</p>
    <p>Please contact the administrator if you believe this is an error.</p>
    <button onclick="window.location.href='${pageContext.request.contextPath}/'" class="btn">Go back</button>
</div>
</body>
</html>