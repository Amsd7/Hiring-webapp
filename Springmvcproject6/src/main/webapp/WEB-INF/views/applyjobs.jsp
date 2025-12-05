<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Apply for Job</title>
    <style>
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

        .container {
            width: 600px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            animation: fadeIn 1s ease-in-out;
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            font-weight: 500;
            margin-top: 15px;
            display: block;
        }

        select, textarea {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 12px;
            border: 1px solid #ccc;
            font-size: 15px;
            transition: 0.3s ease;
            background: #fff;
        }

        select:focus, textarea:focus {
            border-color: #6dcff6;
            box-shadow: 0 0 8px rgba(109,207,246,0.6);
        }

        input[type="submit"] {
            margin-top: 20px;
            background: linear-gradient(135deg, #6dcff6, #ff9a8b);
            color: #fff;
            border: none;
            padding: 12px 20px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s ease;
            width: 100%;
        }

        input[type="submit"]:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 6px 18px rgba(0,0,0,0.2);
        }

        .job-details {
            margin-top: 20px;
            background: rgba(255,255,255,0.9);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: 0.3s ease;
        }

        .job-details p {
            margin: 8px 0;
            font-size: 15px;
            color: #333;
        }

        .job-details strong {
            color: #ff6f61;
        }

        p.success {
            color: green;
            background: #e8f5e9;
            padding: 12px;
            border-radius: 12px;
            margin-top: 15px;
            font-weight: 500;
        }

        p.error {
            color: red;
            background: #fdecea;
            padding: 12px;
            border-radius: 12px;
            margin-top: 15px;
            font-weight: 500;
        }

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

<div class="container">
    <h2>Apply for a Job</h2>

    <form action="/candidate/applyJob" method="post">
        <label>Select Job:</label>
        <select name="jobId" id="jobSelect" required onchange="showDetails(this)">
            <option value="">-- Select a Job --</option>
            <c:forEach var="job" items="${jobs}">
                <option value="${job.id}"
                        data-company="${job.client.companyname}"
                        data-address="${job.jobLocation}"
                        data-skills="${job.requiredSkills}"
                        data-salary="${job.salary}">
                    ${job.jobTitle}
                </option>
            </c:forEach>
        </select>

        <div id="jobInfo" class="job-details" style="display:none;">
            <p><strong>Company:</strong> <span id="company"></span></p>
            <p><strong>Address:</strong> <span id="address"></span></p>
            <p><strong>Required Skills:</strong> <span id="skills"></span></p>
            <p><strong>Salary:</strong> <span id="salary"></span></p>
        </div>

        <input type="submit" value="Apply Now">

        <c:if test="${not empty success}">
            <p class="success">${success}</p>
        </c:if>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
    </form>

    <a href="/candidate/home" class="back">Back to Dashboard</a>
</div>

<script>
    function showDetails(select) {
        const option = select.options[select.selectedIndex];
        if (option.value) {
            document.getElementById("jobInfo").style.display = "block";
            document.getElementById("company").innerText = option.dataset.company;
            document.getElementById("address").innerText = option.dataset.address;
            document.getElementById("skills").innerText = option.dataset.skills;
            document.getElementById("salary").innerText = option.dataset.salary;
        } else {
            document.getElementById("jobInfo").style.display = "none";
        }
    }
</script>

</body>
</html>
