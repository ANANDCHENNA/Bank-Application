<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Details</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            line-height: 1.6;
        }

        .container {
            background: #1e1e1e; /* Dark container background */
            padding: 40px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 600px;
            max-width: 100%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: #ffffff; /* White text color */
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }

        .details {
            text-align: left;
            margin-bottom: 20px;
        }

        .details p {
            margin-bottom: 10px;
            line-height: 1.8;
        }

        .details strong {
            color: #4d79ff; /* Blue color for strong text */
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ffffff; /* White color for back link */
            text-decoration: none;
            font-size: 20px;
            opacity: 0.7;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer Details</h1>
        
        <!-- Display customer details -->
        <div class="details">
            <p><strong>Account Number:</strong> <%= request.getAttribute("accountNumber") %></p>
            <p><strong>Name:</strong> <%= request.getAttribute("fullName") %></p>
            <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
            <p><strong>Phone Number:</strong> <%= request.getAttribute("phoneNumber") %></p>
            <p><strong>Address:</strong> <%= request.getAttribute("address") %></p>
            <p><strong>Aadhaar Number:</strong> <%= request.getAttribute("aadharNo") %></p>
            <p><strong>Status:</strong> <%= request.getAttribute("status") %></p>
        </div>
        
        <a href="adminDashboard.jsp" class="back-link">&larr; Back</a>
    </div>
</body>
</html>
