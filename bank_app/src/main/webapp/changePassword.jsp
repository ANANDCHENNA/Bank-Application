<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: rgb(2,0,36);
			background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
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
        h1 {
            color: #ffffff;
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
        }
        form {
            text-align: left;
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: #ffffff;
        }
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
        input[type="password"]:focus {
            outline: none;
            border: 2px solid #0A21C0;
        }
        input[type="submit"] {
            width: 100%;
            padding: 15px;
            background-color: #0A21C0;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-sizing: border-box;
        }
        input[type="submit"]:hover {
            background: rgb(2,0,36);
			background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
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
        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #ffffff;
        }
        .error {
            color: #ff0000;
        }
        .success {
            color: #00ff00;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Change Password</h1>
        <% if (session.getAttribute("errorMessage") != null) { %>
            <p class="message error"><%= session.getAttribute("errorMessage") %></p>
            <% session.removeAttribute("errorMessage"); %>
        <% } else if (session.getAttribute("successMessage") != null) { %>
            <p class="message success"><%= session.getAttribute("successMessage") %></p>
            <% session.removeAttribute("successMessage"); %>
        <% } %>
        <form action="ChangePasswordServlet" method="post" onsubmit="return validateForm()">
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>
            <label for="confirmNewPassword">Confirm New Password:</label>
            <input type="password" id="confirmNewPassword" name="confirmNewPassword" required><br><br>
            <input type="submit" value="Change Password">
            <a href="customerDashboard.jsp" class="back-link">&larr; Back</a>
        </form>
    </div>

    <script>
        function validateForm() {
            var newPassword = document.getElementById("newPassword").value;
            var confirmNewPassword = document.getElementById("confirmNewPassword").value;

            if (newPassword.length < 8) {
                alert("New Password must be at least 8 characters long.");
                return false;
            }

            if (newPassword !== confirmNewPassword) {
                alert("New Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
