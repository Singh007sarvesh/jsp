<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "com.Database"%>
<%
	session = request.getSession();
	if(session.getAttribute("user")==null){
		response.sendRedirect("home.jsp");
	}
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style type="text/css">
			#wrapper{
				width:100%;
			}
			#container{
				width:80%;
				height:auto;
				border: 1px solid;
				margin-left:10%;
				margin-top:8%;
			}
			a{
				text-decoration:none;
			}
			table{
				margin:20px;
				width:80%;
				margin-left:30px;
			}
			td{
				background-color:#f5f0f0;
				color:black;
			}
		</style>
	<meta charset="ISO-8859-1">
	<title>View Request</title>
	</head>
<body>
	<nav class="navbar navbar-inverse">
			<div class="container-fluid">
		   		<div class="navbar-header">
		      		<a class="navbar-brand" href="#">WebSiteName</a>
		    	</div>
		    	<ul class="nav navbar-nav">
		      		<li ><a href="/RBidding/Logout.jsp">Logout</a></li>
		    	</ul>
		  	</div>
		</nav>
		<div id="wrapper">
			<div id="container">
				<table>
					<% 
						Connection con = Database.con();
						Statement st=con.createStatement();
						String email = (String)session.getAttribute("user");
						String sql ="select * from request where email='"+email+"' and status = '1' ";
						try
						{
							ResultSet resultSet = st.executeQuery(sql);
							while(resultSet.next())
							{
								%>
								<tr>
								<td><%=resultSet.getString("item") %></td>
								<td><%=resultSet.getString("email") %></td>
								<td><a href="/RBidding/seller/setsession.jsp?bid=<%=resultSet.getString("rid") %>">View Bid</a></td>
								</tr>
								<% 
							}
							con.close();
						}
						catch (Exception e)
						{
							out.println(e);
						}
						%>
				</table>
			</div>
		</div>
</body>
</html>