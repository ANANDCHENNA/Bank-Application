package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get parameters from the form
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Validate passwords
        if (!newPassword.equals(confirmNewPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Passwords do not match.");
            response.sendRedirect("changePassword.jsp"); // Redirect back to change password form
            return;
        }

        HttpSession session = request.getSession();
        String accountNumber = (String) session.getAttribute("accountNumber");

        if (accountNumber == null || accountNumber.isEmpty()) {
            session.setAttribute("errorMessage", "Session expired or account number not found.");
            response.sendRedirect("changePassword.jsp"); // Redirect back to change password form
            return;
        }

        // Update password in the database
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            String sql = "UPDATE customer SET password = ? WHERE account_number = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, accountNumber);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                session.setAttribute("successMessage", "Password updated successfully.");
                response.sendRedirect("changePassword.jsp"); // Redirect back to change password form
            } else {
                session.setAttribute("errorMessage", "Failed to update password. Please try again.");
                response.sendRedirect("changePassword.jsp"); // Redirect back to change password form
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error occurred: " + e.getMessage());
            response.sendRedirect("changePassword.jsp"); // Redirect back to change password form
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
