<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Schedule Interview</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3);
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: rgba(255,255,255,0.85);
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
            font-weight: 600;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
        }

        input[type="text"],
        input[type="date"],
        input[type="time"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 12px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus,
        textarea:focus {
            border-color: #6dcff6;
            box-shadow: 0 0 6px rgba(109,207,246,0.5);
            outline: none;
        }

        button {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            border-radius: 25px;
            border: none;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 6px 18px rgba(0,0,0,0.2);
        }

        a.back {
            display: block;
            width: 150px;
            text-align: center;
            margin: 20px auto 0 auto;
            padding: 10px 15px;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.7);
            color: #ff6f61;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s ease;
        }

        a.back:hover {
            background: rgba(255, 255, 255, 1);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Schedule Interview</h2>

    <form action="/employeer/select" method="post">
        <input type="hidden" name="applicationId" value="${applicationId}" />

        <label>Date:</label>
        <input type="date" name="interviewDate" required>

        <label>Time:</label>
        <input type="time" name="interviewTime" required>

        <label>Location:</label>
        <input type="text" name="location" required>

        <label>Company:</label>
        <input type="text" name="company" required>

        <label>Details:</label>
        <textarea name="details" rows="4"></textarea>

        <button type="submit">Send Interview Mail</button>
    </form>

    <a href="/employeer/home" class="back">Back</a>
</div>

</body>
</html>
