package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement withdrawStmt = null;
        PreparedStatement transactionStmt = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Check if sufficient balance is available
            double currentBalance = getCurrentBalance(conn, accountno);
            request.setAttribute("balance", currentBalance); // Set the balance attribute

            if (currentBalance >= amount) {
                // Begin transaction
                conn.setAutoCommit(false);

                // Update balance in the customer table
                withdrawStmt = conn.prepareStatement("UPDATE customer SET balance = balance - ? WHERE account_number = ?");
                withdrawStmt.setDouble(1, amount);
                withdrawStmt.setString(2, accountno);
                int rowCount = withdrawStmt.executeUpdate();

                if (rowCount > 0) {
                    // Record transaction in the transactions table
                    transactionStmt = conn.prepareStatement("INSERT INTO transactions (account_number, type, amount) VALUES (?, ?, ?)");
                    transactionStmt.setString(1, accountno);
                    transactionStmt.setString(2, "Withdraw");
                    transactionStmt.setDouble(3, amount);
                    transactionStmt.executeUpdate();

                    // Commit transaction
                    conn.commit();

                    // Get updated balance from the database
                    double updatedBalance = getCurrentBalance(conn, accountno);

                    // Set success message with updated balance in session attribute
                    request.getSession().setAttribute("message", "Withdrawal successful. Updated balance: " + updatedBalance);

                    // Set the balance attribute to display in withdrawMoney.jsp
                    request.setAttribute("balance", updatedBalance);

                    // Redirect back to withdrawMoney.jsp after successful withdrawal
                    request.getRequestDispatcher("withdrawMoney.jsp").forward(request, response);
                } else {
                    // Rollback transaction if withdrawal failed
                    conn.rollback();

                    // Set error message if withdrawal failed
                    request.getSession().setAttribute("errorMessage", "Withdrawal failed. Please try again.");
                    response.sendRedirect("withdrawMoney.jsp?accountno=" + accountno);
                }
            } else {
                // Set error message if insufficient balance
                request.getSession().setAttribute("errorMessage", "Insufficient balance for withdrawal.");
                response.sendRedirect("withdrawMoney.jsp?accountno=" + accountno);
            }

        } catch (ClassNotFoundException | SQLException e) {
            // Rollback transaction on any exception
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace(); // Log rollback exception
                }
            }
            e.printStackTrace();
            // Set error message for any exception
            request.getSession().setAttribute("errorMessage", "An error occurred. Please try again later.");
            response.sendRedirect("withdrawMoney.jsp?accountno=" + accountno);
        } finally {
            // Close resources and restore auto-commit
            try {
                if (withdrawStmt != null) withdrawStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Restore auto-commit mode
                    conn.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace(); // Log close exception
            }
        }
    }

    private double getCurrentBalance(Connection conn, String accountno) throws SQLException {
        PreparedStatement balanceStmt = null;
        ResultSet rs = null;
        double balance = 0.0;
        try {
            balanceStmt = conn.prepareStatement("SELECT balance FROM customer WHERE account_number = ?");
            balanceStmt.setString(1, accountno);
            rs = balanceStmt.executeQuery();
            if (rs.next()) {
                balance = rs.getDouble("balance");
            }
        } finally {
            if (rs != null) rs.close();
            if (balanceStmt != null) balanceStmt.close();
        }
        return balance;
    }
}
