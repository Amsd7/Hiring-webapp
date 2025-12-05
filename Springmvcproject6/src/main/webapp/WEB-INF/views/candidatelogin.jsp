<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Candidate Login</title>
    <style>
        /* Body & background */
        body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a8edea, #fed6e3);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Login Card */
        .login-card {
            width: 380px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(15px);
            padding: 40px 35px;
            border-radius: 25px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            transition: 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            color: #333;
        }

        /* Error message */
        .error-msg {
            color: #ff4d4d;
            background: #fdecea;
            padding: 12px;
            border-radius: 12px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: 500;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        label {
            font-weight: 500;
            display: block;
            margin-top: 10px;
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #ccc;
            margin-top: 5px;
            margin-bottom: 15px;
            font-size: 15px;
            transition: 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #6dcff6;
            box-shadow: 0 0 10px rgba(109, 207, 246, 0.5);
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 14px;
            border: none;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* Optional: fade-in animation */
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(10px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .login-card {
            animation: fadeIn 0.8s ease-in-out;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Candidate Login</h2>

    <!-- Display error message if credentials are wrong -->
    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <form action="/candidate" method="post">
        <label>Email:</label>
        <input type="text" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <input type="submit" value="Login">
    </form>
</div>

</body>
</html>
