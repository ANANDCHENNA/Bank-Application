package servlets;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        String accountNumber = request.getParameter("accountNumber");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            String sql = "SELECT * FROM customer WHERE account_number = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNumber);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Check if customer status is active
                String status = rs.getString("status");
                if ("ACTIVE".equals(status)) {
                    // Valid credentials and active status, set session attribute and redirect to dashboard
                    HttpSession session = request.getSession();
                    session.setAttribute("accountNumber", accountNumber); // Use "accountNumber" consistently
                    response.sendRedirect("customerDashboard.jsp");
                } else {
                    // Inactive status, set error message and redirect to login page
                    request.setAttribute("errorMessage", "Your account is inactive. Please contact customer support.");
                    request.getRequestDispatcher("customerLogin.jsp").forward(request, response);
                }
            } else {
                // Invalid account number or password, set error message and redirect to login page
                request.setAttribute("errorMessage", "Invalid account number or password.");
                request.getRequestDispatcher("customerLogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Print error message in the console
            PrintWriter out = response.getWriter();
            out.println("Error occurred: " + e.getMessage());
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
