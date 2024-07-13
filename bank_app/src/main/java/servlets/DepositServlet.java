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

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement depositStmt = null;
        PreparedStatement transactionStmt = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Update balance in the customer table
            depositStmt = conn.prepareStatement("UPDATE customer SET balance = balance + ? WHERE account_number = ?");
            depositStmt.setDouble(1, amount);
            depositStmt.setString(2, accountno);
            int rowCount = depositStmt.executeUpdate();

            if (rowCount > 0) {
                // Record transaction in the transactions table
                transactionStmt = conn.prepareStatement("INSERT INTO transactions (account_number, type, amount) VALUES (?, ?, ?)");
                transactionStmt.setString(1, accountno);
                transactionStmt.setString(2, "Deposit");
                transactionStmt.setDouble(3, amount);
                transactionStmt.executeUpdate();

                // Get updated balance from the database
                double updatedBalance = getCurrentBalance(conn, accountno);

                // Set success message with updated balance in request attribute
                request.setAttribute("message", "Deposit successful. Updated balance: " + updatedBalance);

                // Forward to depositMoney.jsp to display the message
                request.getRequestDispatcher("depositMoney.jsp").forward(request, response);
            } else {
                // Set error message if deposit failed
                request.setAttribute("errorMessage", "Deposit failed. Please try again.");
                request.getRequestDispatcher("depositMoney.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Set error message for any exception
            request.setAttribute("errorMessage", "An error occurred. Please try again later.");
            request.getRequestDispatcher("depositMoney.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (depositStmt != null) depositStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
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
