<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account Inactive</title>
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
            background-color: #0A21C0;
            transform: translateY(-3px);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Account Inactive</h1>
        <p>Your account is currently inactive. Please contact Admin or Visit Bank.</p>
        <a href="customerLogin.jsp" class="back-link">&larr; Back to Login</a>
    </div>
</body>
</html>
