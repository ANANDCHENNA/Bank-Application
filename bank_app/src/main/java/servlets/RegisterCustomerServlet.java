package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/BankDB";
    static final String DB_USER = "root";
    static final String DB_PASS = "12345678";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String aadharNo = request.getParameter("aadharno");
        String phoneNo = request.getParameter("phoneno");
        String address = request.getParameter("address");
        double balance = Double.parseDouble(request.getParameter("balance"));
        String dob = request.getParameter("dob");
        String accountType = request.getParameter("account_type");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "INSERT INTO customer (account_number, password, full_name, email, phone_number, address, aadharno, balance, status, dob, account_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'ACTIVE', ?, ?)";
            ps = conn.prepareStatement(sql);

            String accountNumber = generateAccountNumber();
            String password = generatePassword();

            ps.setString(1, accountNumber);
            ps.setString(2, password);
            ps.setString(3, firstName + " " + lastName);
            ps.setString(4, email);
            ps.setString(5, phoneNo);
            ps.setString(6, address);
            ps.setString(7, aadharNo);
            ps.setDouble(8, balance);
            ps.setString(9, dob);
            ps.setString(10, accountType);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                request.setAttribute("accountNumber", accountNumber);
                request.setAttribute("password", password);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("email", email);
                request.setAttribute("phoneNo", phoneNo);
                request.setAttribute("address", address);
                request.setAttribute("balance", balance);

                request.getRequestDispatcher("registration-success.jsp").forward(request, response);
            } else {
                out.println("<h2>Registration failed!</h2>");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
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

    private String generateAccountNumber() {
        Random rand = new Random();
        int num = 1000000 + rand.nextInt(9000000);
        return String.valueOf(num);
    }

    private String generatePassword() {
        String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        StringBuilder sb = new StringBuilder(8);
        Random random = new Random();
        for (int i = 0; i < 8; i++) {
            sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }
}
