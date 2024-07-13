package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TransactionsServlet")
public class TransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("account_number");

        List<String> transactions = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");
            pst = conn.prepareStatement("SELECT timestamp, type, amount FROM transactions WHERE account_number = ?");
            pst.setString(1, accountNumber);
            rs = pst.executeQuery();

            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("timestamp");
                String type = rs.getString("type");
                double amount = rs.getDouble("amount");

                String transactionInfo = "Timestamp: " + timestamp + ", Type: " + type + ", Amount: " + amount;
                transactions.add(transactionInfo);
            }

            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("viewTransactions.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
            request.getRequestDispatcher("transactionError.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
