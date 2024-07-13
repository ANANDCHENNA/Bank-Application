<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page session="true" %>

<%
    // Assuming you have a session attribute "accountNumber" set after customer login
    String accountNumber = (String) session.getAttribute("accountNumber");
    String fullName = "";

    if (accountNumber != null) {
        try {
            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/BankDB";
            String dbUser = "root";
            String dbPassword = "12345678";

            // Establish connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL query to fetch customer details
            String sql = "SELECT full_name FROM customer WHERE account_number = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, accountNumber);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                fullName = resultSet.getString("full_name");
                session.setAttribute("full_name", fullName); // Set full_name in session
            }

            // Close the connections
            resultSet.close();
            statement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp");
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
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%); /* Darker background */
            color: #ffffff; /* Light text color */
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        
        /* Navbar Styles */
        .navbar {
            background-color: #0a0a0a; /* Dark Navbar */
            padding: 10px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .navbar .user-info {
            color: #ffffff;
            margin-left: 300px; /* Adjust margin as needed */
            font-size: 16px;
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
            background: #1e1e1e; /* Dark container background */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Added shadow style */
            width: 100%;
            max-width: 900px;
            margin-top: 20px;
            transition: box-shadow 0.3s ease-in-out; /* Smooth transition for shadow */
            animation: fadeIn 1s ease-in-out; /* Added animation */
        }

        .container:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5); /* Increased shadow on hover */
        }
        
        .container h1 {
            color: #ffffff;
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .container p {
            color: #ffffff;
            font-size: 18px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* Button Styles */
        .button {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 10px auto;
            padding: 15px 30px;
            background-color: #141619; /* Dark button color */
            color: #ffffff;
            text-decoration: none;
            text-align: center;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }
        
        .button:hover {
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%); /* Darker button color on hover */
            transform: translateY(-3px);
        }
        
        /* Logout Button */
        .logout-button {
            padding: 10px 20px;
            background-color: #0A21C0; /* Blue color */
            text-decoration: none;
            text-align: center;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            border: 2px solid transparent;
            transition: background-color 0.3s, color 0.3s, transform 0.3s, border-color 0.3s;
            margin-top: 10px;
            margin-bottom: 10px;
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
            display: flex; /* Added for positioning */
            align-items: center; /* Added for positioning */
            justify-content: center;
        }
        
        .logout-button:hover {
            background: rgb(27,18,18);
            background: linear-gradient(236deg, rgba(27,18,18,1) 0%, rgba(255,0,0,1) 51%, rgba(255,70,0,1) 100%); /* Blue color on hover */
            border-color: #050A44;
            color: #ffffff; /* Text color becomes white on hover */
        }
        
        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Responsive Design */
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
