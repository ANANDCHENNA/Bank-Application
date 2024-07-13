<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
        
        .navbar .admin-info {
            font-size: 14px;
            color: #ffffff;
            margin-right: 10px; /* Adjust margin as needed */
        }
        
        .navbar a {
            color: #ffffff;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
            display: flex; /* Added to align items vertically */
            align-items: center; /* Added to align items vertically */
        }
        .navbar .user-info {
            
            color: #ffffff;
            margin-left: 400px;
            font-size: 16px; /* Adjust margin as needed */
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
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%); /* Darker button color on hover */
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
            opacity: 0.8;
        }
        
        /* Logged-in Info */
        .logged-in-info {
            background-color: rgba(255, 255, 255, 0.1);
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 10px;
            text-align: center;
            width: 100%;
            max-width: 300px;
            color: #ffffff;
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
        <a href="#" class="user-info">Hi,Admin</a>
        <a href="#" onclick="logout()" class="logout-button">Logout</a>
    </div>
    
    <div class="container">
        <h1>Admin Dashboard</h1>
        <a href="registerCustomer.jsp" class="button">Register a Customer</a>
        <a href="viewCustomer.jsp" class="button">View Customer Details</a>
        <a href="enterAccountNumber.jsp" class="button">Edit Customer Details</a>
        <a href="closeCustomer.jsp" class="button">Close Customer Account</a>
        
        <a href="reopenCustomer.jsp" class="button">Reopen Customer Account</a>
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
