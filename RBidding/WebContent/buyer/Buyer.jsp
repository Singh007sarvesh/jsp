<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "com.Database"%>
<%@page import = "java.text.SimpleDateFormat"%>
<%@page import ="java.util.Date" %>
<%@page import ="java.text.ParseException" %>
<%@page import ="java.text.DateFormat" %>
<%@page import ="java.time.LocalTime" %>
<%@page import ="java.time.ZoneId" %>
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
			width:40%;
			height:auto;
			border: 1px solid;
			margin-left:30%;
			margin-top:10%;
		}
		h4{
			margin-left:40%;
		}
		table{
			margin:15px;
		}
		a{
			text-decoration:none;
			margin-left:50%;
			margin-top:-50px;
		}
	</style>
<meta charset="ISO-8859-1">
<title>Buyer</title>
</head>
<body>
	<nav class="navbar navbar-inverse">
			<div class="container-fluid">
		   		<div class="navbar-header">
		      		<a class="navbar-brand" href="#" style="color:white;">WebSiteName</a>
		    	</div>
		    	<ul class="nav navbar-nav">
		    		
		      		<li ><a href="/RBidding/Logout.jsp"><label style="color:white;">Logout</label></a></li>
		    	</ul>
		    	<a href="/RBidding/index.jsp" style="color:white;">Back</a>
		  	</div>
		  	
	</nav>
	<div id="wrapper">
		<div id="container">
			<form action="Buyer.jsp" method="POST">
				<table>
					<tr>
						<td>Start Time</td>
						<td><input type="datetime-local" name="stime"  required /></td>
					</tr>
					<tr>
						<td>Close Time</td>
						<td><input type="datetime-local" name="ctime" required /></td>
					</tr>
					<tr>
						<td>Select Request Item</td>
						<td><select name="item">
					    <option value="Nokia 6.1">Nokia 6.1</option>
					    <option value="Samsung Galaxy s7">Samsung Galaxy s7</option>
					    <option value="fiat">Fiat</option>
					    <option value="audi">Audi</option>
					  </select></td>
					</tr>
					<tr>
						<td style="margin-left:200px;"><input type="submit" name="sub" value="Submit" id="button"></td>
					</tr>
				</table>
				<a href="viewRequest.jsp">View Request</a>
			</form>
		</div>
	</div>
	<%
		String stime = request.getParameter("stime");
		String ctime = request.getParameter("ctime");
		
		LocalTime timeKolkata = LocalTime.now(ZoneId.of("Asia/Kolkata"));
		String item = request.getParameter("item");
		String email = (String)session.getAttribute("user");
		Connection con = Database.con();
		Statement st=con.createStatement();
	    Date dateobj = new Date();
	    
		long diff=0;
		long currentTime=0,start=0,end=0;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
        String strDate = dateFormat.format(dateobj);
        Date date3=new SimpleDateFormat("yyyy-mm-dd hh:mm:ss").parse(strDate);
		currentTime = (date3.getTime());
		if(request.getParameter("sub")!=null)
		{	
			String startHour ="", startMinute="", closeHour="", closeMinute="";
			
			startHour= startHour + stime.charAt(11) + stime.charAt(12);
			startMinute = startMinute + stime.charAt(14) + stime.charAt(15);
			closeHour= closeHour + ctime.charAt(11) + ctime.charAt(12);
			closeMinute = closeMinute + ctime.charAt(14) + ctime.charAt(15);
			long timeinsecond=0;
				 try{
				    	Date date1=new SimpleDateFormat("yyyy-mm-dd").parse(stime);
				    	start = date1.getTime();
				    	Date date2=new SimpleDateFormat("yyyy-mm-dd").parse(ctime);
				    	end = date2.getTime();
				}
				catch(Exception e){
					out.println(e);
				}
			end = (end + Integer.parseInt(closeHour)*(3600) + Integer.parseInt(closeMinute)*(60));
			start = (start + Integer.parseInt(startHour)*(3600) + Integer.parseInt(startMinute)*(60));
			if((currentTime < start) && (currentTime < end)) //Check end and start date should be greater than current date
            {
				if(((end - start )/3600) > 2  ){
					String query = "insert into request(rid,email,stime,ctime,item,status)values("
						+null+",'"+email+"','"+stime+"','"+ctime+"','"+item+"','"+1+"')";
					try
					{
						st.executeUpdate(query);
						%>
						<script>alert('Your request has been created successfully');</script>
						<%
					}
					catch(Exception e){
						%>
						<script>alert('Your request has not created');</script>
						<%
					}
				}
				else
				{
					%>
					<script>alert('Bidding duration should be greater than 2 hours');</script>
					<%
				}
            }
			else
			{
				%>
				<script>alert('End and start date should be greater than current date');</script>
				<%
					
			}
		}
	%>
</body>
</html>