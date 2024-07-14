package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReopenCustomerServlet")
public class ReopenCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/BankDB";
    static final String DB_USER = "root";
    static final String DB_PASS = "12345678";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accountNumber = request.getParameter("accountno");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "UPDATE customer SET status = 'ACTIVE' WHERE account_number = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNumber);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Redirect to the success JSP page
                response.sendRedirect("reopenCustomerSuccess.jsp");
            } else {
                response.getWriter().println("<h2>Account reopening failed! Account number not found.</h2>");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h2>Error occurred: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
