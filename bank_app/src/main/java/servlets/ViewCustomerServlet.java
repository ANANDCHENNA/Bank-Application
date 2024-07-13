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

@WebServlet("/ViewCustomerServlet")
public class ViewCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/BankDB";
    static final String DB_USER = "root";
    static final String DB_PASS = "12345678";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT account_number, full_name, email, phone_number, address, aadharno, status FROM customer WHERE account_number = ?";
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

                // Forward to JSP for rendering
                request.getRequestDispatcher("/viewCustomerDetails.jsp").forward(request, response);
            } else {
                // Customer not found
                PrintWriter out = response.getWriter();
                out.println("<html><body><h2>Customer not found.</h2><br><a href='viewCustomer.jsp'>Back</a></body></html>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            PrintWriter out = response.getWriter();
            out.println("<html><body><h2>Error occurred: " + e.getMessage() + "</h2></body></html>");
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
