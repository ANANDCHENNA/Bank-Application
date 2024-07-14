package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountno = request.getParameter("accountno");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Check account balance
            String checkBalanceSQL = "SELECT balance FROM customer WHERE account_number = ?";
            ps = conn.prepareStatement(checkBalanceSQL);
            ps.setString(1, accountno);
            rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal balance = rs.getBigDecimal("balance");

                if (balance.compareTo(BigDecimal.ZERO) > 0) {
                    // If balance is greater than zero, set warning message and redirect
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Withdraw the remaining balance before closing the account.");
                    response.sendRedirect("closeAccount.jsp");
                    return;
                }
            }

            // Update account status to INACTIVE
            String updateSQL = "UPDATE customer SET status = 'INACTIVE' WHERE account_number = ?";
            ps = conn.prepareStatement(updateSQL);
            ps.setString(1, accountno);

            int rowCount = ps.executeUpdate();

            if (rowCount > 0) {
                // Invalidate the session to log out the user
                HttpSession session = request.getSession();
                session.invalidate();

                // Redirect to account closed confirmation page
                response.sendRedirect("accountClosed.jsp");
            } else {
                // If update fails, redirect back with error message
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Failed to close account. Please try again.");
                response.sendRedirect("closeAccount.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
            response.sendRedirect("closeAccount.jsp");
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (ps != null)
                    ps.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
