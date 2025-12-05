<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Applicants for Job</title>
    <style>
        body {
            font-family: "Poppins", sans-serif;
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

        /* Table Styling */
        table {
            width: 80%;
            margin: 0 auto 30px auto;
            border-collapse: collapse;
            background: rgba(255,255,255,0.85);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }

        th {
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 600;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            color: #444;
        }

        tr:hover {
            background: rgba(255, 170, 170, 0.1);
        }

        /* Buttons */
        button {
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
        }

        button:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* Links */
        a {
            color: #ff6f61;
            font-weight: 600;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        a.btn {
            display: inline-block;
            padding: 8px 15px;
            border-radius: 25px;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: white;
            font-weight: 600;
            text-decoration: none;
            transition: 0.3s ease;
        }

        a.btn:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        /* Back link */
        a.back {
            display: block;
            width: 180px;
            margin: 0 auto;
            text-align: center;
            padding: 10px 15px;
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.7);
            color: #ff6f61;
            font-weight: 600;
            margin-top: 20px;
            transition: 0.3s ease;
        }

        a.back:hover {
            background: rgba(255, 255, 255, 1);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<h2>Applicants for Job: ${job.jobTitle}</h2>

<table>
    <thead>
        <tr>
            <th>#</th>
            <th>Name</th>
            <th>Email</th>
            <th>Resume</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>

    <tbody>
        <c:if test="${empty applications}">
            <tr>
                <td colspan="6" style="text-align:center;">No applicants yet.</td>
            </tr>
        </c:if>

        <c:forEach var="app" items="${applications}" varStatus="loop">
            <tr>
                <td>${loop.count}</td>
                <td>${app.candidate.user.name}</td>
                <td>${app.candidate.user.email}</td>
                <td>
                    <a href="/uploads/${app.candidate.resume}" target="_blank">View Resume</a>
                </td>
                <td>${app.status}</td>
                <td>
                    <!-- APPLIED → SELECT INTERVIEW -->
                    <c:if test="${app.status eq 'Applied'}">
                        <form action="/employeer/select/${app.id}" method="get">
                            <button type="submit">Select for Interview</button>
                        </form>
                    </c:if>

                    <!-- SELECTED → HIRE -->
                    <c:if test="${app.status eq 'Selected for Interview'}">
                        <form action="/employeer/offer-form/${app.id}" method="get" style="margin-bottom:5px;">
                            <button type="submit">Hire</button>
                        </form>
                    </c:if>

                    <!-- HIRED → DOWNLOAD OFFER -->
                    <c:if test="${app.status eq 'Hired'}">
                        <a href="/employeer/download-offer/${app.id}" class="btn">Download Offer Letter</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<a href="/employeer/home" class="back">Back to Dashboard</a>

</body>
</html>
