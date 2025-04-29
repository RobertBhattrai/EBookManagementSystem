<%@ page import="models.UserModel" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UserModel loggedInUser = (UserModel) session.getAttribute("loggedInUser");

    if (loggedInUser == null || !"user".equals(loggedInUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/LoginServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Home</title>
</head>
<body>

<h2>Welcome, <%= loggedInUser.getName() %>!</h2>
<p>You are logged in as a <strong><%= loggedInUser.getRole() %></strong>.</p>

<h3>Your Profile Details:</h3>
<ul>
    <li><strong>Full Name:</strong> <%= loggedInUser.getName() %></li>
    <li><strong>Username:</strong> <%= loggedInUser.getUsername() %></li>
    <li><strong>Email:</strong> <%= loggedInUser.getEmail() %></li>
    <li><strong>Phone:</strong> <%= loggedInUser.getPhone() %></li>
    <li><strong>Address:</strong> <%= loggedInUser.getAddress() %></li>
</ul>

<p><a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></p>

</body>
</html>
