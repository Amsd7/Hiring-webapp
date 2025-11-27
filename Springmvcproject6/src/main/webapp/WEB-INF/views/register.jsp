<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Poppins", Arial, sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3); /* cool mint + warm peach */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #444;
        }

        .container {
            width: 380px;
            background: rgba(255, 255, 255, 0.65);
            backdrop-filter: blur(10px);
            padding: 35px 45px;
            border-radius: 25px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            animation: fadeIn 1.2s ease-in-out;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 30px;
            font-weight: 600;
            color: #333;
        }

        label {
            font-weight: 500;
            display: block;
            margin-top: 12px;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #6dcff6;
            box-shadow: 0 0 6px rgba(109, 207, 246, 0.6);
        }

        .error {
            color: #ff4d4d;
            background: rgba(255, 0, 0, 0.1);
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
        }

        input[type="submit"] {
            margin-top: 20px;
            width: 100%;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b); /* cool blue + warm coral */
            border: none;
            padding: 12px;
            border-radius: 30px;
            color: white;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        input[type="submit"]:hover {
            transform: translateY(-3px) scale(1.03);
            box-shadow: 0 6px 16px rgba(0,0,0,0.25);
        }

       
    </style>
</head>

<body>

<div class="container">
    <h2>Register</h2>

    <!-- Display error message -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/save" method="post">

        <label for="name">Name:</label>
        <input type="text" id="name" name="name"/>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required/>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password"/>

        <label for="role">Role:</label>
        <select id="role" name="role" required>
            <option value="">-- Select Role --</option>
            <option value="candidate">Candidate</option>
            <option value="client">Client</option>
        </select>

        <input type="submit" value="Register"/>

    </form>
</div>

</body>
</html>
