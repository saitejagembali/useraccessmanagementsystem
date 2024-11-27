<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>

<%
    String role = (String) session.getAttribute("role");

    if (role == null || (!"Admin".equals(role) && !"Manager".equals(role))) {
        response.sendRedirect("index.jsp");
        return;
    }

    ResultSet requests = (ResultSet) request.getAttribute("requests");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Pending Requests</title>
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

        h2 {
            color: #4CAF50;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 5px 10px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        button.reject {
            background-color: #FF0000;
        }

        button:hover {
            opacity: 0.8;
        }

        p {
            color: red;
            text-align: center;
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
        <h1>Manage Pending Requests</h1>
    </header>

    
    <main>
        <h2>Pending Requests</h2>
        
        <% if (errorMessage != null) { %>
            <p><%= errorMessage %></p>
        <% } %>

        <table>
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>Username</th>
                    <th>Software</th>
                    <th>Access Type</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    while (requests != null && requests.next()) {
                %>
                <tr>
                    <td><%= requests.getInt("id") %></td>
                    <td><%= requests.getString("username") %></td>
                    <td><%= requests.getString("software") %></td>
                    <td><%= requests.getString("access_type") %></td>
                    <td><%= requests.getString("reason") %></td>
                    <td><%= requests.getString("status") %></td>
                    <td>
                        <form action="ApprovalServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="requestId" value="<%= requests.getInt("id") %>">
                            <input type="hidden" name="action" value="approve">
                            <button type="submit">Approve</button>
                        </form>
                        <form action="ApprovalServlet" method="POST" style="display:inline;">
                            <input type="hidden" name="requestId" value="<%= requests.getInt("id") %>">
                            <input type="hidden" name="action" value="reject">
                            <button type="submit" class="reject">Reject</button>
                        </form>
                    </td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
    </main>

    
    <footer>
        
    </footer>
</body>
</html>
