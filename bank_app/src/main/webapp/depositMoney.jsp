<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Deposit Money</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: rgb(2,0,36);
			background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
            color: #ffffff;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .container {
            background: #1e1e1e;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            margin-top: 20px;
            transition: box-shadow 0.3s ease-in-out;
            animation: fadeIn 1s ease-in-out;
        }

        .container:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
        }

        .container h1 {
            color: #ffffff;
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .container label {
            display: block;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .container input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #2C2E3A; /* Darker textbox background */
            color: #ffffff; /* White text color */
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        
        .container input[type="number"]:focus{
        	outline: none;
            border: 2px solid #0A21C0;
        }

        .button {
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 10px auto;
            padding: 15px 30px;
            background-color: #141619;
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
			background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
            transform: translateY(-3px);
        }

        .message {
            margin: 20px 0;
            padding: 10px;
            background-color: #0A21C0;
            color: #ffffff;
            text-align: center;
            border-radius: 6px;
            font-size: 16px;
            max-width: 500px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        .error {
            background-color: #c00;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ffffff; /* White color for back link */
            text-decoration: none;
            font-size: 20px;
            opacity: 0.7;
            background-color: #1e1e1e; /* Dark container background for links */
            padding: 10px 20px;
            border-radius: 8px;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Deposit Money</h1>

        <% String message = (String) request.getAttribute("message");
           String errorMessage = (String) request.getAttribute("errorMessage");
           if (message != null) { %>
           <div class="message"><%= message %></div>
           <% } %>
           <% if (errorMessage != null) { %>
           <div class="message error"><%= errorMessage %></div>
           <% } %>

        <form action="DepositServlet" method="post">
            <input type="hidden" name="accountno" value="<%= request.getParameter("accountno") %>">
            <label for="amount">Amount to Deposit:</label>
            <input type="number" id="amount" name="amount" step="100" required><br><br>
            <input type="submit" value="Deposit" class="button">
            <a href="customerDashboard.jsp" class="back-link">&larr; Back</a>
        </form>
    </div>
</body>
</html>
