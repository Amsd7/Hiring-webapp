<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Offer Letter</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #a8edea, #fed6e3);
            margin: 0;
            padding: 20px 0;
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: 600;
            margin-bottom: 30px;
        }

        form {
            width: 50%;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.85);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
        }

        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 12px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus {
            border-color: #6dcff6;
            box-shadow: 0 0 6px rgba(109, 207, 246, 0.5);
        }

        button {
            margin-top: 20px;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 15px;
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
            margin: 25px auto 0 auto;
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

<h2>Create Offer Letter for ${app.candidate.user.name}</h2>

<form action="/employeer/generate-offer/${app.id}" method="post">
    <label>Candidate Name:</label>
    <input type="text" name="candidateName" value="${app.candidate.user.name}" required>

    <label>Job Title:</label>
    <input type="text" name="jobTitle" value="${app.job.jobTitle}" required>

    <label>Joining Date:</label>
    <input type="date" name="joiningDate" required>

    <label>Salary:</label>
    <input type="text" name="salary" required>

    <label>HR Name:</label>
    <input type="text" name="hrName" value="HR Department" required>

    <label>HR Contact:</label>
    <input type="text" name="hrContact" value="HR Department" required>

    <button type="submit">Generate Offer Letter</button>
</form>

<a href="/employeer/home" class="back">Back</a>

</body>
</html>
