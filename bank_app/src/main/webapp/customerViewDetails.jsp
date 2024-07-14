<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Account Details</title>
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
            color: #fffff; /* Blue color for heading */
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }

        .details {
            text-align: left;
            margin-top: 20px;
        }

        .details ul {
            list-style-type: none;
            padding: 0;
        }

        .details li {
            margin-bottom: 15px; /* Increased spacing between list items */
        }

        .details li span {
            font-weight: bold;
            color: #4d79ff; /* Blue color for strong text */
            display: inline-block;
            min-width: 140px; /* Ensure consistent width for labels */
            margin-right: 10px; /* Space between label and value */
        }

        .balance {
            font-size: 18px; /* Larger font size for balance */
            color: #ffd700; /* Gold color for balance */
            background: #333333; /* Slightly lighter background for balance */
            padding: 10px 15px;
            border-radius: 8px;
            
            display: inline-block;
            margin-bottom: 15px; /* Spacing at the bottom */
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
        <h1>Customer Account Details</h1>
        <div class="details">
            <ul>
                <li><span>Full Name :</span> <%= request.getAttribute("fullName") %></li>
                <li><span>Account Number :</span> <%= request.getAttribute("accountNumber") %></li>
                <li><span>Account Type :</span> <%= request.getAttribute("accountType") %></li>
                <li><span>Email :</span> <%= request.getAttribute("email") %></li>
                <li><span>Phone Number :</span> <%= request.getAttribute("phoneNumber") %></li>
                <li><span>Address :</span> <%= request.getAttribute("address") %></li>
                <li><span>Date of Birth :</span> <%= request.getAttribute("dob") %></li>
                <li><span>Aadhar Number :</span> <%= request.getAttribute("aadharNo") %></li>
                <li><span>Balance :</span> <span class="balance"><%= request.getAttribute("balance") %></span></li>
                <li><span>Status :</span> <%= request.getAttribute("status") %></li>
            </ul>
        </div>
        <a href="customerDashboard.jsp" class="back-link">&larr; Back</a>
    </div>
</body>
</html>
