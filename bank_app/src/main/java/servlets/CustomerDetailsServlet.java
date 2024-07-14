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
import javax.servlet.http.HttpSession;

@WebServlet("/CustomerDetailsServlet")
public class CustomerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/BankDB";
    static final String DB_USER = "root";
    static final String DB_PASS = "12345678";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber"); // Consistent attribute name

        if (accountNumber == null || accountNumber.isEmpty()) {
            System.out.println("Account number is null or empty. Redirecting to login page.");
            response.sendRedirect("customerLogin.jsp"); // Redirect to login page if session attribute is null
            return;
        }

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT account_number, full_name, email, phone_number, address, aadharno, status, account_type, dob, balance FROM customer WHERE account_number = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, accountNumber);
            rs = pst.executeQuery();

            if (rs.next()) {
                // Set attributes for JSP rendering
                request.setAttribute("accountNumber", rs.getString("account_number"));
                request.setAttribute("fullName", rs.getString("full_name"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phoneNumber", rs.getString("phone_number"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("aadharNo", rs.getString("aadharno"));
                request.setAttribute("status", rs.getString("status"));
                request.setAttribute("accountType", rs.getString("account_type"));
                request.setAttribute("dob", rs.getString("dob"));
                request.setAttribute("balance", rs.getString("balance"));

                // Forward to JSP for rendering
                request.getRequestDispatcher("/customerViewDetails.jsp").forward(request, response);
            } else {
                System.out.println("Customer not found with account number: " + accountNumber);
                response.sendRedirect("customerLogin.jsp?error=Customer+not+found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customerLogin.jsp?error=" + e.getMessage());
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
