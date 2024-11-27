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

@WebServlet("/RequestAccessServlet")
public class RequestAccessServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String softwareName = request.getParameter("software");
        String reason = request.getParameter("reason");
        String username = (String) request.getSession().getAttribute("username");

        try (Connection conn = database.DatabaseConnection.getConnection()) {
            
            String getUserIdQuery = "SELECT id FROM users WHERE username = ?";
            PreparedStatement stmtUserId = conn.prepareStatement(getUserIdQuery);
            stmtUserId.setString(1, username);
            ResultSet rsUserId = stmtUserId.executeQuery();

            if (rsUserId.next()) {
                int userId = rsUserId.getInt("id");

               
                String getSoftwareIdQuery = "SELECT id FROM software WHERE name = ?";
                PreparedStatement stmtSoftwareId = conn.prepareStatement(getSoftwareIdQuery);
                stmtSoftwareId.setString(1, softwareName);
                ResultSet rsSoftwareId = stmtSoftwareId.executeQuery();

                if (rsSoftwareId.next()) {
                    int softwareId = rsSoftwareId.getInt("id");

                   
                    String insertRequestQuery = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, 'Read', ?, 'Pending')";
                    PreparedStatement stmtRequest = conn.prepareStatement(insertRequestQuery);
                    stmtRequest.setInt(1, userId);
                    stmtRequest.setInt(2, softwareId);
                    stmtRequest.setString(3, reason);

                    int rows = stmtRequest.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("index.jsp?request=submitted");  // Redirect after submitting the request
                    } else {
                        response.getWriter().println("Error: Request not submitted.");
                    }
                } else {
                    response.getWriter().println("Error: Software not found.");
                }
            } else {
                response.getWriter().println("Error: User not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
