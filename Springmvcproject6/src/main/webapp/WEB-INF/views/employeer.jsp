<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Employeer Dashboard</title>
	<style>
	body {
	    font-family: "Poppins", sans-serif;
	    margin: 0;
	    padding: 0;
	    background: linear-gradient(135deg, #a8edea, #fed6e3);
	    min-height: 100vh;
	}

	/* Main container */
	.container {
	    width: 85%;
	    margin: 30px auto;
	    background: rgba(255, 255, 255, 0.85);
	    backdrop-filter: blur(10px);
	    padding: 35px;
	    border-radius: 20px;
	    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
	    animation: fadeIn 1s ease-in-out;
	}

	/* Headings */
	h2, h3 {
	    color: #333;
	    font-weight: 600;
	}

	h2 {
	    text-align: center;
	    font-size: 28px;
	    margin-bottom: 20px;
	}

	h3 {
	    margin-top: 30px;
	    font-size: 22px;
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
	    font-weight: 500;
	    margin-top: 12px;
	    display: block;
	}

	input[type="text"], textarea {
	    width: 100%;
	    padding: 12px;
	    margin-top: 5px;
	    border-radius: 12px;
	    border: 1px solid #ccc;
	    font-size: 15px;
	    transition: 0.3s ease;
	    background: #fff;
	}

	input:focus, textarea:focus {
	    border-color: #6dcff6;
	    box-shadow: 0 0 6px rgba(109, 207, 246, 0.6);
	}

	/* Buttons */
	input[type="submit"], button {
	    background: linear-gradient(135deg, #6dcff6, #ff9a8b);
	    color: #fff;
	    border: none;
	    padding: 12px 20px;
	    border-radius: 30px;
	    margin-top: 20px;
	    cursor: pointer;
	    font-weight: 600;
	    font-size: 16px;
	    transition: 0.3s ease;
	}

	input[type="submit"]:hover, button:hover {
	    transform: translateY(-3px) scale(1.03);
	    box-shadow: 0 6px 18px rgba(0,0,0,0.2);
	}

	/* Horizontal line */
	hr {
	    border: none;
	    border-top: 1px solid #ddd;
	    margin: 40px 0;
	}

	/* Table styling */
	table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	    background: white;
	    border-radius: 12px;
	    overflow: hidden;
	    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
	}

	th {
	    background: linear-gradient(135deg, #6dcff6, #ff9a8b);
	    color: white;
	    padding: 12px;
	    font-weight: 600;
	    text-align: left;
	}

	td {
	    padding: 12px;
	    border-bottom: 1px solid #eee;
	    color: #444;
	}

	tr:hover {
	    background: rgba(255, 170, 170, 0.1);
	}

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
    <h2>Employeer Dashboard</h2>
    <a class="logout" href="/logout">Logout</a>

    <h3>Welcome, ${sessionScope.currentUser.name}</h3>

    <!-- Company Profile Section -->
    <h3>Company Profile</h3>
    <form action="/employeer/updateProfile" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${profile.id}">

        <label>Company Name:</label>
        <input type="text" name="companyname" value="${profile.companyname}" required>

		<label>Company Address:</label>
		   <input type="text" name="companyaddress" value="${profile.companyaddress}" required>

        <label>Contact Number:</label>
        <input type="text" name="contactnumber" value="${profile.contactnumber}" required>
		<input type="submit" value="update profile">
		    </form>

		    <hr>

		    <!-- Post New Job -->
		    <h3>Post a New Job</h3>
		    <form action="/employeer/postJob" method="post">
		        <label>Job Title:</label>
		        <input type="text" name="jobTitle" required>

		        <label>Job Description:</label>
		        <textarea name="jobDescription" rows="4" required></textarea>

		        <label>Required Skills:</label>
		        <input type="text" name="requiredSkills" placeholder="e.g. Java, Spring, SQL" required>
				
				<label>Location:</label>
				<input type="text" name="jobLocation"  required>

		        <label>Salary:</label>
		        <input type="text" name="salary" required>

		        <input type="submit" value="Post Job">
		    </form>

		    <hr>

		    <!-- List of Posted Jobs -->
		    <h3>Your Posted Jobs</h3>
		    <table>
		        <tr>
					<th>Job Title</th>
					        <th>Description</th>
					        <th>Skills</th>
					        <th>Location</th>
					        <th>Salary</th>
					        <th>Action</th>
		        </tr>
		        <c:forEach var="job" items="${jobs}">
		            <tr>
						<td>${job.jobTitle}</td>
						<td>${job.jobDescription}</td>
						<td>${job.requiredSkills}</td>
						<td>${job.jobLocation}</td>
						<td>${job.salary}</td>
		                <td>
		                    <a href="/employeer/viewApplicants/${job.id}">View Applicants</a>
		                </td>
		            </tr>
		        </c:forEach>
		    </table>

		</div>

		</body>
		</html>

