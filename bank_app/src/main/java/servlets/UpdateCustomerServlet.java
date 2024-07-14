package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountno");
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phoneNo = request.getParameter("phoneno");
        String address = request.getParameter("address");
        String aadharNo = request.getParameter("aadharno");

        Connection conn = null;
        PreparedStatement pstUpdate = null;

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Prepare SQL statement
            String sql = "UPDATE customer SET full_name=?, email=?, phone_number=?, address=?, aadharno=? WHERE account_number=?";
            pstUpdate = conn.prepareStatement(sql);
            pstUpdate.setString(1, fullName);
            pstUpdate.setString(2, email);
            pstUpdate.setString(3, phoneNo);
            pstUpdate.setString(4, address);
            pstUpdate.setString(5, aadharNo);
            pstUpdate.setString(6, accountNumber);

            // Execute update
            int rowsAffected = pstUpdate.executeUpdate();

            if (rowsAffected > 0) {
                // Redirect to a success page (optional)
                response.sendRedirect("updateCustomerSuccess.jsp?update=success");
            } else {
                // No rows affected, meaning the account number was not found
                response.sendRedirect("updateCustomerSuccess.jsp?update=notfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database operation failed.", e);
        } finally {
            try {
                if (pstUpdate != null) pstUpdate.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
