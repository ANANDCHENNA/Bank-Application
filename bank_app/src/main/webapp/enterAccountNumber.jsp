<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Account Number</title>
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
            margin: 0;
        }

        .container {
            background: #1e1e1e; /* Dark container background */
            padding: 40px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 400px;
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

        form {
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #cccccc; /* Light color for labels */
        }

        input[type="text"] {
            width: 100%;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 16px;
            border: 1px solid #2C2E3A;
            border-radius: 5px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            background-color: #2C2E3A; /* Darker textbox background */
            color: #ffffff; /* White text color */
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #0A21C0; /* Blue color for focus */
        }

        input[type="submit"] {
            width: 100%;
            padding: 15px;
            background-color: #171717; /* Blue color for button */
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
            display: inline-block;
            margin-top: 20px;
            color: #ffffff; /* White color for back link */
            text-decoration: none;
            font-size: 20px;
            text-align: center;
            opacity: 70%;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Enter Account Number</h1>
        
        <%-- Display error message if any --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
        <% } %>
        
        <form action="FetchCustomerDetailsServlet" method="post">
            <label for="accountno">Enter Account Number:</label>
            <input type="text" id="accountno" name="accountno" required><br><br>
            <input type="submit" value="Continue">
        </form>
        
        <a href="adminDashboard.jsp" class="back-link">&larr; Back</a>
    </div>
</body>
</html>