<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		<link rel="stylesheet" type="text/css" href="css/bstyle.css">
		<meta charset="ISO-8859-1">
		<title>Home</title>
	</head>
	<body>
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
		   		<div class="navbar-header">
		      		<a class="navbar-brand" href="#">WebSiteName</a>
		    	</div>
		    	<ul class="nav navbar-nav">
		      		<li ><a href="Logout.jsp">Logout</a></li>
		    	</ul>
		  	</div>
		</nav>
		<div id="wrapper">
			<div id="container">
				<form action="index.jsp" method="POST">
					<table>
						<tr>
							<td>Buyer</td>
							<td><input type="radio" name="Buyer" id ="radio" value="Buyer"></td>
						</tr>
						<tr>
							<td> Seller </td>
							<td> <input type="radio" name="Buyer" id ="radio" value="Seller"></td>
						</tr>
						<tr>
							<td><input type="submit" name="sub" value="Save Preference" id="button"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<%
			if(request.getParameter("Buyer") != null) {
		        if(request.getParameter("Buyer").equals("Buyer")) {
		        	String buyer = request.getParameter("Buyer");
		        	String site = "buyer/Buyer.jsp";
		            response.setStatus(response.SC_MOVED_TEMPORARILY);
		            response.setHeader("Location", site);
		            //out.println("Radio button 1 was selected.<BR>" + buyer);
		        }
		        else {
		            out.println("Radio button 1 was not selected.<BR>");
		        }
			}
			if(request.getParameter("Buyer") != null) {
		        if(request.getParameter("Buyer").equals("Seller")) {
		        	String seller = request.getParameter("Buyer");
		            //out.println("Radio button 2 was selected.<BR>" + seller);
		        	String site = "seller/seller.jsp";
		            response.setStatus(response.SC_MOVED_TEMPORARILY);
		            response.setHeader("Location", site);
		        }
		        else {
		            out.println("Radio button 2 was not selected.<BR>");
		        }
			}
	    %>
	</body>
</html>