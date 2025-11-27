<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Candidate Dashboard</title>
	<style>

	/* Smooth pastel background */
	body {
	    font-family: "Poppins", sans-serif;
	    margin: 0;
	    padding: 0;
	    background: linear-gradient(135deg, #a8edea, #fed6e3);
	}

	/* Main container */
	.container {
	    width: 85%;
	    background: rgba(255, 255, 255, 0.8);
	    backdrop-filter: blur(10px);
	    margin: 40px auto;
	    padding: 35px;
	    border-radius: 20px;
	    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
	    animation: fadeIn 1s ease-in-out;
	}

	/* Heading */
	h2 {
	    text-align: center;
	    color: #333;
	    font-size: 28px;
	    font-weight: 600;
	}

	/* Logout button */
	.logout {
	    float: right;
	    text-decoration: none;
	    color: white;
	    background: linear-gradient(135deg, #ff9a8b, #ff6a88);
	    padding: 10px 18px;
	    border-radius: 25px;
	    font-weight: 600;
	    transition: 0.3s ease;
	}

	.logout:hover {
	    transform: translateY(-3px);
	    background: linear-gradient(135deg, #ff6a88, #ff9a8b);
	}

	/* Form styling */
	form {
	    margin-top: 20px;
	}

	label {
	    font-weight: 600;
	    margin-top: 12px;
	    display: block;
	}

	input[type="text"],
	input[type="email"],
	input[type="file"] {
	    width: 100%;
	    padding: 10px;
	    border-radius: 12px;
	    border: 1px solid #ccc;
	    margin-top: 5px;
	    font-size: 15px;
	    background: #fff;
	    transition: 0.3s ease;
	}

	input:focus {
	    border-color: #6dcff6;
	    box-shadow: 0 0 6px rgba(109, 207, 246, 0.6);
	}

	/* Submit buttons */
	input[type="submit"] {
	    background: linear-gradient(135deg, #6dcff6, #ff9a8b);
	    border: none;
	    margin-top: 20px;
	    width: 230px;
	    padding: 12px;
	    border-radius: 30px;
	    color: white;
	    font-size: 16px;
	    font-weight: 600;
	    cursor: pointer;
	    transition: 0.3s ease;
	}

	input[type="submit"]:hover {
	    transform: translateY(-3px) scale(1.03);
	    box-shadow: 0 6px 18px rgba(0,0,0,0.2);
	}

	/* Horizontal line */
	hr {
	    border: none;
	    border-top: 1px solid #ddd;
	    margin: 25px 0;
	}

	/* Table */
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 15px;
	    background: white;
	    border-radius: 15px;
	    overflow: hidden;
	    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
	}

	th {
	    background: linear-gradient(135deg, #6dcff6, #ff9a8b);
	    padding: 12px;
	    color: white;
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

	/* Links */
	a {
	    color: #ff6f61;
	    font-weight: 600;
	    text-decoration: none;
	}

	a:hover {
	    text-decoration: underline;
	}

	

	</style>

</head>
<body>

<div class="container">
    <a class="logout" href="/logout">Logout</a>
	<h2>Welcome, ${profile.user.name}</h2>
	<p>Email: ${profile.user.email}</p>

    <h3>Update Your Profile</h3>
    <form action="/candidate/updateProfile" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${profile.id}">
		
		<label>Name:</label>
		<input type="text" name="name" value="${profile.name}" required>

		<label>Email:</label>
		<input type="email" name="email" value="${profile.email}" required>


        <label>Highest Qualification:</label>
        <input type="text" name="highestQualification" value="${profile.highestQualification}" required>

        <label>Passing Year:</label>
        <input type="text" name="passingYear" value="${profile.passingYear}" required>

        <label>Skills:</label>
        <input type="text" name="skills" value="${profile.skills}" placeholder="e.g. Java, Spring MVC, MySQL">

        <label>Experience:</label>
        <input type="text" name="experience" value="${profile.experience}" placeholder="e.g. 1 year, Fresher">

        <label>Upload Resume (PDF only):</label>
        <input type="file" name="resumeFile">

        <input type="submit" value="Update Profile">
    </form>

	<c:if test="${not empty profile.resume}">
	    <p>Your uploaded resume:
	        <a href="${pageContext.request.contextPath}/uploads/${profile.resume}" target="_blank">
	            View Resume
	        </a>
	    </p>
	</c:if>
    <hr>
	<!-- Apply for Job Section -->
	<form action="/candidate/applyJob" method="get">
	    <input type="submit" value="Apply for Job" />
	</form>
	<hr>



	<table>
	    <tr>
	        <th>Job Title</th>
	        <th>Company</th>
	        <th>Status</th>
	        <th>Interview Date</th>
	        <th>Offer Letter</th>
	    </tr>

	    <c:forEach var="app" items="${applications}">
	        <tr>
	            <td>${app.job.jobTitle}</td>
	            <td>${app.job.client.companyname}</td>
	            <td>${app.status}</td>

	            <td>
	                <c:choose>
	                    <c:when test="${empty app.interviewDate}">Pending</c:when>
	                    <c:otherwise>${app.interviewDate}</c:otherwise>
	                </c:choose>
	            </td>

	            <!-- OFFER LETTER DOWNLOAD COLUMN -->
	            <td>
	                <c:if test="${not empty app.offerLetter}">
						<a href="/employeer/download-offer/${app.id}" 
						   class="btn btn-success">
						   Download Offer Letter
						</a>

	                </c:if>

	                <c:if test="${empty app.offerLetter}">
	                    <span style="color:gray;">Not Available</span>
	                </c:if>
	            </td>
	        </tr>
	    </c:forEach>
	</table>

</div>

</body>
</html>
