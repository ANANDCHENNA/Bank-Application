<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page session="true" %>

<%
    String accountNumber = (String) session.getAttribute("accountNumber");
    String fullName = "";

    if (accountNumber != null) {
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            String dbURL = "jdbc:mysql://localhost:3306/BankDB";
            String dbUser = "root";
            String dbPassword = "12345678";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "SELECT full_name FROM customer WHERE account_number = ?";
            statement = conn.prepareStatement(sql);
            statement.setString(1, accountNumber);

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                fullName = resultSet.getString("full_name");
                session.setAttribute("full_name", fullName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException ignored) {}
            if (statement != null) try { statement.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    } else {
        response.sendRedirect("customerLogin.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Reset and Base Styles */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
            color: #ffffff;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #0a0a0a;
            padding: 10px 20px;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 900px;
        }
        
        .navbar .brand {
            font-size: 24px;
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
        }

        .navbar .user-info {
            color: #ffffff;
            font-size: 16px;
            margin-left:350px;
        }
        
        .navbar a {
            color: #ffffff;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
        }

        .navbar a:hover {
            color: #dddddd;
        }

        /* Main Container Styles */
        .container {
            background: #1e1e1e;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 900px;
            margin-top: 20px;
            transition: box-shadow 0.3s;
            animation: fadeIn 1s;
        }

        .container:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
        }

        .container h1 {
            color: #ffffff;
            font-size: 32px;
            margin-bottom: 20px;
            text-align: center;
        }

        .button {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 10px auto;
            padding: 15px;
            background-color: #141619;
            color: #ffffff;
            text-decoration: none;
            text-align: center;
            border-radius: 6px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        
        .button:hover {
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
            transform: translateY(-3px);
        }

        /* Logout Button */
        .logout-button {
            padding: 10px 20px;
            background-color: #0A21C0;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            margin-top: 10px;
            margin-bottom: 10px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
        }
        
        .logout-button:hover {
            background: linear-gradient(236deg, rgba(27,18,18,1) 0%, rgba(255,0,0,1) 51%, rgba(255,70,0,1) 100%);
            color: #ffffff;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            .button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="#" class="brand">Bank Application</a>
        <div class="user-info">Hi, <%= session.getAttribute("full_name") %></div>
        <a href="#" onclick="logout()" class="logout-button">Logout</a>
    </div>
    
    <div class="container">
        <h1>Customer Dashboard</h1>
        <a href="CustomerDetailsServlet" class="button">View Account Details</a>
        <a href="TransactionsServlet?account_number=<%= accountNumber %>" class="button">View Transactions</a>
        <a href="depositMoney.jsp?accountno=<%= accountNumber %>" class="button">Deposit Money</a>
        <a href="withdrawMoney.jsp?accountno=<%= accountNumber %>" class="button">Withdraw Money</a>
        <a href="changePassword.jsp" class="button">Change Password</a>
        <a href="closeAccount.jsp" class="button">Close Account</a>
    </div>
    
    <script>
        function logout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "index.jsp";
            }
        }
    </script>
</body>
</html>
