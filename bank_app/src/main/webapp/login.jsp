<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        /* Your existing styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%);
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
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #ffffff;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #2C2E3A;
            color: #ffffff;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border: 2px solid #0A21C0;
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
        }
        input[type="submit"]:hover {
            background: rgb(78,52,96);
			background: linear-gradient(90deg, rgba(78,52,96,1) 0%, rgba(162,38,38,1) 50%, rgba(161,108,34,1) 100%);
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ffffff;
            opacity: 0.7;
            text-decoration: none;
            font-size: 16px;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .warning {
            display: none;
            color: #ff0000;
            margin-bottom: 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Login</h2>
        <form action="Login" method="post">
            <div id="warning" class="warning">Invalid username or password</div>
            <label for="username">Username :</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="password">Password :</label>
            <input type="password" id="password" name="password" required><br><br>
            <input type="submit" value="Admin Login">
            <a href="index.jsp" class="back-link">&larr; Back</a>
        </form>
    </div>
    <script>
        // Check if there's a warning message to show
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            document.getElementById('warning').style.display = 'block';
        }
    </script>
</body>
</html>
