<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "com.Bid"%>
<%@page import = "com.Database"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import ="java.util.Date" %>
<%@page import ="java.text.ParseException" %>
<%@page import ="java.text.DateFormat" %>
<%@page import ="java.time.LocalTime" %>
<%@page import ="java.time.ZoneId" %>
<%@page import = "com.RevBid"%>
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
			height:400px;
			border: 1px solid;
			margin-left:30%;
			margin-top:5%;
			box-shadow: 12px 12px 2px 1px black;
		}
		table{
			margin-left:10px;
		}
		.pBid{
			background-color:#f04124;
			color:white;
			margin-left:150px;
			font-size:25px;
		}
		label{
			font-size:15px;
			font-weight: bold;
		}
	</style>
<meta charset="ISO-8859-1">
<title>Bid</title>
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
			<%
				String amt = request.getParameter("amount");
				String rid = (String)session.getAttribute("rid");
				String cemail = (String)session.getAttribute("user");
				Connection con = Database.con();
				Statement st=con.createStatement();
				String sql = "SELECT * FROM revparticipant where rid= '"+rid+"' order by amount limit 1";
				String result = "SELECT * FROM request where rid= '"+rid+"' ";
		        ResultSet resultset = st.executeQuery(sql);
		        resultset.next();
		       	 
		        String amount ="",useremail="",itemname="",stime="",ctime="";
		        try{
		         amount = resultset.getString("amount");
		         useremail = resultset.getString("email");
		        }
		        catch(Exception e){
		        	
		        }
		        
		        ResultSet resultset1 = st.executeQuery(result);
		        resultset1.next();
		        itemname = resultset1.getString("item");
		        stime = resultset1.getString("stime");
		        ctime = resultset1.getString("ctime");
		        String str[] = ctime.split("[- :]",ctime.length());
		        String str1[] = stime.split("[- :]",stime.length());
				final Bid bid = new Bid(rid,cemail,amount);
				if(request.getParameter("sub") != null){
					boolean bool = bid.updateBid(amt);
	 				if(bool){
	 					response.sendRedirect("seller.jsp");
					}
					else{
						out.println("<script>alert('plz enter lowest price for reverse bid');</script>");
					}
	 			}
			%>
			 <table>
				<tr>
					<td>
						<h4>Item Name: <% out.println(itemname); %></h4>
					</td>
				</tr>
				<tr>
					<td>
						<h4>Bid Amount: <% out.println(amount); %></h4>
					</td>
				</tr>
				<tr>
					<td>
						<h4>Lowest Bidder: <% out.println(useremail); %></h4>
					</td>
				</tr>
				<tr>
					<td>
					<label id="bid1">Time Left to Bid: 
					<script>
					var endyear=	<%= str[0]%>
					var endmonth =	<%= str[1]%>
					var enddate =	<%= str[2]%>
					var endhour =	<%= str[3]%>
					var endminute =	<%= str[4]%>
					var endsecond =	<%= str[5]%>
					var startyear = <%= str1[0]%>
					var startmonth = <%= str1[1]%>
					var startdate = <%= str1[2]%>
					var starthour = <%= str1[3]%>
					var startminute = <%= str1[4]%>
					var startsecond = <%= str1[5]%>
					var end = new Date(endyear,endmonth-1,enddate,endhour,endminute,endsecond);
					var start = new Date(startyear,startmonth-1,startdate,starthour,startminute,startsecond);
					var _second = 1000;
					var _minute = _second * 60;
					var _hour = _minute * 60;
					var _day = _hour * 24;
					var timer;
					function showRemaining(){
					    var now = new Date();
					    var distance = end - now;
					    var distance1 = now - start;
					    if(distance1 < 0) {
					        document.getElementById('bid1').innerHTML = 'Time Start To Bid  ' + ' ' + '&nbsp;';
					        document.getElementById("bok").style.display='none';
						    distance=start-now;
						    var days = Math.floor(distance / _day);
							var hours = Math.floor((distance % _day) / _hour);
							var minutes = Math.floor((distance % _hour) / _minute);
							var seconds = Math.floor((distance % _minute) / _second);
							document.getElementById('countdown').innerHTML = days + ' days ';
							document.getElementById('countdown').innerHTML += hours + ' hrs ';
							document.getElementById('countdown').innerHTML += minutes + ' mins ';
							document.getElementById('countdown').innerHTML += seconds + 'secs';
							//document.getElementById("bok1").style.visibility='hidden';
					     return;
					    }
						else if (distance < 0) {
							clearInterval(timer);
							document.getElementById('countdown').innerHTML = 'Bidding Closed';
							document.getElementById("bok").style.display='none';
					        //document.getElementById("bok1").style.visibility='visible';
					        return;
					    }
					    document.getElementById('bid1').innerHTML = 'Time Left To Bid  ' + ' ' + '&nbsp;';
					    document.getElementById("bok").style.display='inline';
						var days = Math.floor(distance / _day);
						var hours = Math.floor((distance % _day) / _hour);
						var minutes = Math.floor((distance % _hour) / _minute);
						var seconds = Math.floor((distance % _minute) / _second);
						document.getElementById('countdown').innerHTML = days + ' days ';
						document.getElementById('countdown').innerHTML += hours + ' hrs ';
						document.getElementById('countdown').innerHTML += minutes + ' mins ';
						document.getElementById('countdown').innerHTML += seconds + 'secs';
						//document.getElementById("bok1").style.visibility='hidden';
					}
				    timer = setInterval(showRemaining, 1000);
			        </script></label>
			        <label id="countdown"></label>
					</td>
				</tr>
			</table>
			<form action="SellerBid.jsp" Method="POST" id="bok">
				<table >
					<tr>
						<td><h4>Enter Bid Amount</h4></td>
						<td><input type="text" name="amount" required pattern="^[0-9]+" placeholder="Rs. 10000"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" name="sub" value ="Place Bid" class="pBid"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>