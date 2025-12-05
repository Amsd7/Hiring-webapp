<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Success</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(12px);
            padding: 40px 45px;
            width: 400px;
            text-align: center;
            border-radius: 22px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            color: #333;
            font-size: 26px;
            margin-bottom: 20px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            padding: 12px 20px;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            border-radius: 25px;
            transition: 0.3s ease;
        }

        a:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.25);
        }

    </style>
</head>

<body>

<div class="card">
    <h2>User registered successfully!</h2>
    <a href="welcomepage">Go to Dashboard and Login</a>
</div>

</body>
</html>
