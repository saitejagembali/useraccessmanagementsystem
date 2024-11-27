<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Index Page</title>
    <style>
       
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }

        header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
        }

        main {
            max-width: 800px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
        }

        h1 {
            color: #4CAF50;
            text-align: center;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            margin: 10px 0;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        p {
            font-size: 1rem;
            margin-bottom: 20px;
        }

        footer {
            text-align: center;
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    
    <header>
        <h1>User Access Management System</h1>
    </header>

    
    <main>
        <h1>Welcome to User Access Management System</h1>
        
        <% if (role == null) { %>
            <p>
                <a href="login.jsp">Login</a> | 
                <a href="signup.jsp">Signup</a>
            </p>
        <% } else { %>
            <p>Logged in as: <strong><%= session.getAttribute("username") %> (<%= role %>)</strong></p>
            <ul>
                <% if ("Admin".equals(role) || "Manager".equals(role)) { %>
                    <li><a href="PendingRequestsServlet?action=viewPendingRequests">Manage Pending Requests</a></li>
                    <% if ("Admin".equals(role)) { %>
                        <li><a href="createSoftware.jsp">Create Software</a></li>
                    <% } %>
                <% } %>
                <% if ("Employee".equals(role)) { %>
                    <li><a href="requestAccess.jsp">Request Software Access</a></li>
                <% } %>
            </ul>
        <% } %>
    </main>

    
    <footer>
        
    </footer>
</body>
</html>
