<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reopen Customer Account Success</title>
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
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 40px;
            color : #0A21C0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer Account Reopened Successfully!</h1>
        <p>Redirecting...</p>
        <%-- Automatic redirection after 2 seconds --%>
        <%
            response.setHeader("Refresh", "2;url=adminDashboard.jsp");
        %>
    </div>
</body>
</html>