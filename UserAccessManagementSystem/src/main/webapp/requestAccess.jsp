<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*, database.DatabaseConnection" %>
<%
   
    String role = (String) session.getAttribute("role");

    if (!"Employee".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }

    
    List<String> softwareList = new ArrayList<>();
    try (Connection conn = DatabaseConnection.getConnection()) {
        String sql = "SELECT name FROM software";  // Query to fetch software names
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            softwareList.add(rs.getString("name"));
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error fetching software list.");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Software Access</title>
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
            margin: 50px auto;
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

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        select, textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            width: 100%;
        }

        button:hover {
            background-color: #45a049;
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
        <h2>Request Software Access</h2>
        <form action="RequestAccessServlet" method="POST">
            <label for="software">Software:</label>
            <select id="software" name="software" required>
                <% 
                    // Dynamically populate the dropdown with software options from the list
                    for (String software : softwareList) {
                %>
                    <option value="<%= software %>"><%= software %></option>
                <% 
                    }
                %>
            </select><br><br>

            <label for="reason">Reason:</label>
            <textarea id="reason" name="reason" rows="4" required></textarea><br><br>

            <button type="submit">Request Access</button>
        </form>
    </main>

   
    <footer>
        
    </footer>
</body>
</html>
