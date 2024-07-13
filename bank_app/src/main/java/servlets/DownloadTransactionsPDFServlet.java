package servlets;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/DownloadTransactionsPDFServlet")
public class DownloadTransactionsPDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("account_number");

        if (accountNumber == null || accountNumber.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Account number is required.");
            return;
        }

        List<Transaction> transactions = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

            // Fetch customer balance
            double currentBalance = 0.0;
            pst = conn.prepareStatement("SELECT balance FROM customer WHERE account_number = ?");
            pst.setString(1, accountNumber);
            rs = pst.executeQuery();

            if (rs.next()) {
                currentBalance = rs.getDouble("balance");
            }

            // Fetch last 10 transactions
            pst = conn.prepareStatement("SELECT timestamp, type, amount FROM transactions WHERE account_number = ? ORDER BY timestamp DESC LIMIT 10");
            pst.setString(1, accountNumber);
            rs = pst.executeQuery();

            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("timestamp");
                String type = rs.getString("type");
                double amount = rs.getDouble("amount");

                transactions.add(new Transaction(timestamp, type, amount));
            }

            generatePDF(response, transactions, accountNumber, currentBalance);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF: " + e.getMessage());
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

    private void generatePDF(HttpServletResponse response, List<Transaction> transactions, String accountNumber, double currentBalance) throws DocumentException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=" + accountNumber + "_transactions.pdf");

        Document document = new Document();
        try {
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();
            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Font subtitleFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD);
            Font tableFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);

            // Fetch customer details (full name and email)
            Connection conn = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            String fullName = "";
            String email = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankDB", "root", "12345678");

                // Retrieve customer details
                pst = conn.prepareStatement("SELECT full_name, email FROM customer WHERE account_number = ?");
                pst.setString(1, accountNumber);
                rs = pst.executeQuery();

                if (rs.next()) {
                    fullName = rs.getString("full_name");
                    email = rs.getString("email");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving customer details: " + e.getMessage());
                return;
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // Add customer details to PDF
            Paragraph title = new Paragraph("Transaction History", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph subtitle = new Paragraph("Account Number: " + accountNumber, subtitleFont);
            subtitle.setAlignment(Element.ALIGN_CENTER);
            document.add(subtitle);

            Paragraph customerName = new Paragraph("Customer Name: " + fullName, subtitleFont);
            customerName.setAlignment(Element.ALIGN_CENTER);
            document.add(customerName);

            Paragraph customerEmail = new Paragraph("Email: " + email, subtitleFont);
            customerEmail.setAlignment(Element.ALIGN_CENTER);
            document.add(customerEmail);

            // Add current balance
            Paragraph balance = new Paragraph("Current Balance: " + currentBalance, subtitleFont);
            balance.setAlignment(Element.ALIGN_CENTER);
            document.add(balance);

            // Add space between sections
            document.add(new Paragraph(" "));

            // Add transaction history table
            PdfPTable table = new PdfPTable(3); // 3 columns for timestamp, type, amount
            table.setWidthPercentage(100);

            PdfPCell header1 = new PdfPCell(new Phrase("Timestamp", tableFont));
            PdfPCell header2 = new PdfPCell(new Phrase("Type", tableFont));
            PdfPCell header3 = new PdfPCell(new Phrase("Amount", tableFont));

            table.addCell(header1);
            table.addCell(header2);
            table.addCell(header3);

            for (Transaction transaction : transactions) {
                table.addCell(new Phrase(transaction.getTimestamp().toString(), tableFont));
                table.addCell(new Phrase(transaction.getType(), tableFont));
                table.addCell(new Phrase(String.valueOf(transaction.getAmount()), tableFont));
            }

            document.add(table);

        } finally {
            document.close();
        }
    }

    private static class Transaction {
        private Timestamp timestamp;
        private String type;
        private double amount;

        public Transaction(Timestamp timestamp, String type, double amount) {
            this.timestamp = timestamp;
            this.type = type;
            this.amount = amount;
        }

        public Timestamp getTimestamp() {
            return timestamp;
        }

        public String getType() {
            return type;
        }

        public double getAmount() {
            return amount;
        }
    }
}
