<html>
<head>
    <meta charset="UTF-8">
    <style>
        .navbar {
            background-color: #333;
            overflow: hidden;
            font-family: Arial, sans-serif;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-size: 16px;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        .navbar a.active {
            background-color: #4CAF50;
            color: white;
        }

        /* Clear floats after the navbar */
        .navbar:after {
            content: "";
            display: table;
            clear: both;
        }

        /* Responsive design for smaller screens */
        @media screen and (max-width: 600px) {
            .navbar a {
                float: none;
                display: block;
                text-align: left;
                width: 100%;
                box-sizing: border-box;
            }
        }
    </style>
</head>
<body>
<div class="navbar">
    <a class="active" href="${pageContext.request.contextPath}/">Home</a>
    <a href="${pageContext.request.contextPath}/recent-book">Recent Book</a>
    <a href="${pageContext.request.contextPath}/old-book">Old Book</a>
    <a href="${pageContext.request.contextPath}/new-book">New Book</a>
    <a href="${pageContext.request.contextPath}/settings">Setting</a>
    <a href="${pageContext.request.contextPath}/contact-us">Contact Us</a>
</div>
</body>
</html>