<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Close Account</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
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
        }

        .container p {
            font-size: 18px;
            margin-bottom: 20px;
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
            background: linear-gradient(236deg, rgba(27,18,18,1) 0%, rgba(255,0,0,1) 51%, rgba(255,70,0,1) 100%);
            transform: translateY(-3px);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ffffff;
            text-decoration: none;
            font-size: 20px;
            opacity: 0.7;
            background-color: #141619;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .back-link:hover {
            background: rgb(2,0,36);
			background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(0,212,255,1) 100%);
            transform: translateY(-3px);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
     <script>
        function confirmCloseAccount() {
            return confirm("Are you sure you want to close your account? This action cannot be undone.");
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Close Account</h1>
        <% if (session.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= session.getAttribute("errorMessage") %></p>
            <% session.removeAttribute("errorMessage"); %>
        <% } %>
        <p>Are you sure you want to close your account? This action cannot be undone.</p>
        <form action="CloseAccountServlet" method="post" onsubmit="return confirmCloseAccount();">
            <input type="hidden" name="accountno" value="<%= session.getAttribute("account_number") %>">
            <input type="submit" value="Close Account" class="button">
            <a href="customerDashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
        </form>
    </div>
</body>
</html>
