<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Transactions</title>
    <style>
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
            font-size: 16px;
        }
        
        .navbar a {
            color: #ffffff;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
            display: flex; /* Added to align items vertically */
            align-items: center; /* Added to align items vertically */
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
            overflow-y: auto; /* Scrollbar for overflow */
            max-height: 500px; /* Maximum height for scroll */
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* Align items to the start (left side) */
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
            background-color: #0A21C0; /* Blue color on hover */
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
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #141619; /* Dark table background */
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Added shadow style */
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ffffff;
        }
        
        th {
            background-color: #0A21C0; /* Blue color for table header */
            color: #ffffff;
        }
        
        tr:nth-child(even) {
            background-color: #1e1e1e; /* Darker row color */
        }
        
        tr:hover {
            background-color: #141619; /* Darker row color on hover */
        }
    </style>
</head>
<body>
    
    
    <h1>Transactions</h1>
    
    <div class="container">
        <a href="customerDashboard.jsp" class="button">Go to Dashboard</a>
        <a href="DownloadTransactionsPDFServlet?account_number=<%=request.getParameter("account_number")%>" class="button">Download Statement</a>
        
        <% 
            List<String> transactions = (List<String>) request.getAttribute("transactions");
            if (transactions != null && !transactions.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (String transaction : transactions) { %>
                        <tr>
                            <% 
                                String[] transactionDetails = transaction.split(",");
                                String date = transactionDetails[0];
                                String description = transactionDetails[1];
                                String amount = transactionDetails[2];
                            %>
                            <td><%= date %></td>
                            <td><%= description %></td>
                            <td><%= amount %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p>No transactions found.</p>
        <% } %>
    </div>
</body>
</html>
