

package database;





import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    public static Connection getConnection() throws Exception {
        // PostgreSQL connection details
        String url = "jdbc:postgresql://localhost:5432/useraccess"; // Replace with your PostgreSQL DB name
        String username = "postgres"; // Replace with your PostgreSQL username
        String password = "root"; // Replace with your PostgreSQL password

        // Register PostgreSQL driver
        Class.forName("org.postgresql.Driver");

        // Return the connection
        return DriverManager.getConnection(url, username, password);
    }
}
