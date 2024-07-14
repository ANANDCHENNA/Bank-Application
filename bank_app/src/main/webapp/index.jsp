<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to the Bank Application</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: rgb(26,59,73);
			background: linear-gradient(90deg, rgba(26,59,73,1) 1%, rgba(52,36,13,1) 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
            background-color: #1e1e1e;
            padding: 40px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 400px;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #ffffff;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }
        form {
            margin-top: 20px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 15px;
            background-color: #171717;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-sizing: border-box;
            margin-bottom: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .admin-login:hover {
            background: rgb(78,52,96);
            background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%);
        }
        .customer-login:hover {
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
        }
        .separator {
            color: #ffffff;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to the Bank Application</h2>
        <form action="login.jsp">
            <input type="submit" value="Admin Login" class="admin-login">
        </form>
        <div class="separator">or</div>
        <form action="customerLogin.jsp">
            <input type="submit" value="Customer Login" class="customer-login">
        </form>
    </div>
</body>
</html>