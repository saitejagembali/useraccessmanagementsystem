<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    
    if (username == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
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
            max-width: 600px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
        }

        h1 {
            color: #4CAF50;
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            text-align: center;
            font-size: 1.1rem;
        }

        .menu {
            margin: 20px 0;
            padding: 0;
            list-style-type: none;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .menu li {
            margin: 10px 0;
        }

        .menu a {
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .menu a:hover {
            background-color: #0056b3;
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
        <h1>Welcome, <%= username %>!</h1>
        <p>Your Role: <strong><%= role %></strong></p>

        <ul class="menu">
            <% if ("Admin".equals(role)) { %>
                <li><a href="createSoftware.jsp">Create Software</a></li>
                <li><a href="pendingRequests.jsp">Manage Pending Requests</a></li>
            <% } else if ("Manager".equals(role)) { %>
                <li><a href="pendingRequests.jsp">Approve/Reject Requests</a></li>
            <% } else if ("Employee".equals(role)) { %>
                <li><a href="requestAccess.jsp">Request Software Access</a></li>
            <% } %>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </main>

   
    <footer>
        
    </footer>
</body>
</html>
