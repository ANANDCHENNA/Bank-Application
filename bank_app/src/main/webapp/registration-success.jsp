<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>
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
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%); /* Darker background */
            color: #ffffff; /* Light text color */
            line-height: 1.6;
            text-align: center;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background-color: #1e1e1e; /* Dark container background */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px;
            margin: 20px auto;
            text-align: left;
        }

        h2 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        p {
            color: #ffffff;
            margin-bottom: 10px;
            color : #0A21C0;
        }

        strong {
            color: #ffffff;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ffffff;
            opacity: 70%;
            text-decoration: none;
            font-size: 16px;
            text-align: center;
            transition: opacity 0.3s;
        }

        .back-link:hover {
            opacity: 100%;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Customer Registration Successful</h2>
        <p><strong>Account Number:</strong> <%= request.getAttribute("accountNumber") %></p>
        <p><strong>Password:</strong> <%= request.getAttribute("password") %></p>
        <p><strong>Name:</strong> <%= request.getAttribute("firstName") %> <%= request.getAttribute("lastName") %></p>
        <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
        <p><strong>Phone Number:</strong> <%= request.getAttribute("phoneNo") %></p>
        <p><strong>Address:</strong> <%= request.getAttribute("address") %></p>
        <p><strong>Initial Balance:</strong> <%= request.getAttribute("balance") %></p>
        <a href="adminDashboard.jsp" class="back-link">&larr; Back</a>
    </div>
</body>
</html>
