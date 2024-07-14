package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CloseCustomerServlet")
public class CloseCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/BankDB";
    static final String DB_USER = "root";
    static final String DB_PASS = "12345678";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Prepare SQL statement to update customer status to inactive
            String sql = "UPDATE customer SET status = 'INACTIVE' WHERE account_number = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, accountno);

            // Execute the update operation
            int rowCount = pst.executeUpdate();

            // Output HTML with styling
            if (rowCount > 0) {
                request.setAttribute("successMessage", "Customer account closed successfully.");
            } else {
                request.setAttribute("errorMessage", "Customer not found or account already closed.");
            }

            // Forward to closeCustomerResult.jsp
            request.getRequestDispatcher("closeCustomerResult.jsp").forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
