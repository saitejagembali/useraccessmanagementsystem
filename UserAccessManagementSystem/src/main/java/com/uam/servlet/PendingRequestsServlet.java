package com.uam.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PendingRequestsServlet")
public class PendingRequestsServlet extends HttpServlet {

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("viewPendingRequests".equals(action)) {
          
            try (Connection conn = database.DatabaseConnection.getConnection()) {
                String query = "SELECT r.id, u.username, s.name AS software, r.access_type, r.reason, r.status " +
                               "FROM requests r JOIN users u ON r.user_id = u.id " +
                               "JOIN software s ON r.software_id = s.id WHERE r.status = 'Pending'";

                PreparedStatement stmtRequests = conn.prepareStatement(query);
                ResultSet rsRequests = stmtRequests.executeQuery();

              
                if (!rsRequests.isBeforeFirst()) {
                    request.setAttribute("errorMessage", "No pending requests found.");
                }

              
                request.setAttribute("requests", rsRequests);
                request.getRequestDispatcher("pendingRequests.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            }
        }
    }

  
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POST method not supported.");
    }
}
