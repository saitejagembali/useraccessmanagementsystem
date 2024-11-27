package com.uam.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateSoftwareServlet")
public class CreateSoftwareServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String softwareName = request.getParameter("softwareName");
        String description = request.getParameter("description");

        try (Connection conn = database.DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO software (name, description) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, softwareName);
            stmt.setString(2, description);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("index.jsp?software=created");
            } else {
                response.getWriter().println("Error: Software not created.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
