package com.uam.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int requestId = Integer.parseInt(request.getParameter("requestId"));

        try (Connection conn = database.DatabaseConnection.getConnection()) {
            if ("approve".equals(action)) {
                String updateStatusQuery = "UPDATE requests SET status = 'Approved' WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(updateStatusQuery);
                stmt.setInt(1, requestId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("PendingRequestsServlet?action=viewPendingRequests");
                } else {
                    response.getWriter().println("Error: Request not approved.");
                }
            } else if ("reject".equals(action)) {
                String updateStatusQuery = "UPDATE requests SET status = 'Rejected' WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(updateStatusQuery);
                stmt.setInt(1, requestId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("PendingRequestsServlet?action=viewPendingRequests");
                } else {
                    response.getWriter().println("Error: Request not rejected.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
