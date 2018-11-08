<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "com.Database"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="css/login.css">
	</head>
	<body>
		<h2>Login Form</h2>
			<form action="home.jsp" method = "POST">
				<div class="imgcontainer">
				  <img src="image/img_avatar2.png" alt="Avatar" class="avatar" style="width:70px;height:70px;">
				</div>
				<div class="container">
					<label for="uname"><b>Username</b></label>
					<input type="text" placeholder="Enter Username" name="user" required>
					<label for="psw"><b>Password</b></label>
					<input type="password" placeholder="Enter Password" name="pass" required> 
					<button type="submit" name="sub" value="login">Login</button>
				</div>
			</form>
			<%
				session = request.getSession();
				String user = request.getParameter("user");
				String pass = request.getParameter("pass");
				if(request.getParameter("sub")!=null)
				{
					Connection con = Database.con();
	 				Statement st=con.createStatement();
	 				String query = "select * from user where userid='"+user+"' and password='"+pass+"'";
	 				try{
	 						ResultSet resultSet = st.executeQuery(query);
							if(resultSet.next())
							{
								session = request.getSession();
								session.setAttribute("user",user);
								response.sendRedirect("index.jsp");
							}
							else
								out.println("<script>alert('Enter Valid mail and Password')</script>");
					}
	 				catch(Exception e)
	 				{
	 					out.println("<script>alert('Please Enter Valid Email and Password');</script>");
	 				}
				}
			%>
	</body>
</html>