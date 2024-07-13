<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Customer</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Reset and Base Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%); /* Darker background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background-color: #1e1e1e; /* Dark container background */
            padding: 40px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 600px;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            color: #ffffff; /* Light text color */
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }
        form {
            text-align: left;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #ffffff; /* White label color */
        }
        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #2C2E3A; /* Darker textbox background */
            color: #ffffff; /* White text color */
            box-sizing: border-box;
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="number"]:focus,
        input[type="date"]:focus,
        select:focus {
            outline: none;
            border: 2px solid #0A21C0; /* Blue border on focus */
        }
        select {
            background-color: #2C2E3A; /* Blue background */
            color: #ffffff; /* White text */
            padding: 15px; /* Same padding as button */
            border-radius: 5px; /* Rounded corners */
        }
        select:hover {
            background-color: #050A44; /* Darker blue on hover */
        }
        input[type="submit"] {
            grid-column: span 2;
            width: 100%;
            padding: 15px;
            background-color: #171717; /* Blue button color */
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-sizing: border-box;
        }
        input[type="submit"]:hover {
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%); /* Darker blue on hover */
        }
        .back-link {
            grid-column: span 2;
            display: inline-block;
            margin-top: 20px;
            color: #ffffff; /* White color for back link */
            text-decoration: none;
            font-size: 20px;
            text-align: center;
            opacity: 0.7;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validateForm() {
            var phone = document.getElementById("phoneno").value;
            var email = document.getElementById("email").value;
            var phonePattern = /^[0-9]{10}$/;
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            
            if (!phonePattern.test(phone)) {
                alert("Phone number must be 10 digits.");
                return false;
            }
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Register New Customer</h1>
        <form action="RegisterCustomerServlet" method="post" onsubmit="return validateForm()">
            <label for="firstname">First Name :</label>
            <input type="text" id="firstname" name="firstname" required>
            
            <label for="lastname">Last Name :</label>
            <input type="text" id="lastname" name="lastname" required>
            
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" required>
            
            <label for="phoneno">Phone Number :</label>
            <input type="text" id="phoneno" name="phoneno" required>
            
            <label for="address">Address :</label>
            <input type="text" id="address" name="address" required>
            
            <label for="aadharno">Aadhar Number :</label>
            <input type="text" id="aadharno" name="aadharno" required>
            
            <label for="dob">Date of Birth :</label>
            <input type="date" id="dob" name="dob" required>
            
            <label for="account_type">Account Type :</label>
            <select id="account_type" name="account_type" required>
                <option value="SAVINGS">Savings</option>
                <option value="CURRENT">Current</option>
            </select>
            
            <label for="balance">Initial Balance :</label>
            <input type="number" step="100" id="balance" name="balance" min="1000" required>
            
            <input type="submit" value="Register Customer">
            <a href="adminDashboard.jsp" class="back-link">&larr; Back</a>
        </form>
    </div>
</body>
</html>
