package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FetchCustomerDetailsServlet")
public class FetchCustomerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountno");

        try {
            // Load JDBC driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Prepare SQL statement
            String sql = "SELECT * FROM customer WHERE account_number = ?";
            PreparedStatement pstSelect = conn.prepareStatement(sql);
            pstSelect.setString(1, accountNumber);

            // Execute query
            ResultSet rs = pstSelect.executeQuery();

            if (rs.next()) {
                // Customer found, retrieve details for editing
                String fullName = rs.getString("full_name");
                String email = rs.getString("email");
                String phoneNo = rs.getString("phone_number");
                String address = rs.getString("address");
                String aadharNo = rs.getString("aadharno");

                // Set attributes to forward to editCustomerDetails.jsp
                request.setAttribute("accountno", accountNumber);
                request.setAttribute("fullname", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phoneno", phoneNo);
                request.setAttribute("address", address);
                request.setAttribute("aadharno", aadharNo);

                // Forward to editCustomerDetails.jsp
                request.getRequestDispatcher("editCustomerDetails.jsp").forward(request, response);
            } else {
                // Customer not found
                request.setAttribute("errorMessage", "Customer not found for account number: " + accountNumber);
                request.getRequestDispatcher("enterAccountNumber.jsp").forward(request, response);
            }

            // Close connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database operation failed.", e);
        }
    }
}
