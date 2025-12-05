<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Poppins", Arial, sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3); /* Cool mint + warm peach */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #444;
        }

        .container {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(8px);
            padding: 40px 60px;
            border-radius: 25px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
            animation: fadeIn 1.2s ease-in-out;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 30px;
            font-weight: 600;
            color: #333;
        }

        a {
            text-decoration: none;
            color: #fff;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b); /* Cool blue -> warm coral */
            padding: 12px 22px;
            margin: 0 10px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 500;
            transition: 0.3s ease;
            display: inline-block;
        }

        a:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow: 0 6px 18px rgba(0,0,0,0.2);
        }

       
    </style>
</head>

<body>
    <div class="container">
        <h2>Welcome to Hiring Portal</h2>
        <a href="register">Register</a>
        <a href="candidate">Candidate Login</a>
        <a href="employeer">Employeer Login</a>
    </div>
</body>
</html>
