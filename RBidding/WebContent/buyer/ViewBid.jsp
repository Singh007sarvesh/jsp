<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@page import = "com.Database"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@page import ="java.util.Date" %>
<%
	session = request.getSession();
	if(session.getAttribute("user")==null){
		response.sendRedirect("home.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
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
	<div id="wrapper">
		<div id="container">
			<table>
				<% 
					Connection con = Database.con();
					Statement st=con.createStatement();
					String itemid = (String)session.getAttribute("bid");
					int rid = Integer.parseInt(itemid);
					String receiver = "";
					String sql ="SELECT * FROM revparticipant where rid= '"+rid+"' order by amount limit 1";
					try
					{
						ResultSet resultSet = st.executeQuery(sql);
						while(resultSet.next())
						{
							receiver = resultSet.getString("email");
							%>
							<tr>
								<td><%=resultSet.getString("amount") %></td>
								<td><%=resultSet.getString("email") %></td>
								<td>
								<form action="ViewBid.jsp" method="post">
	                            <button type="submit" name="sub" value="Accept">Accept</button>
	                            </form>
	                            </td>
							</tr>
							<% 
						}
					}
					catch (Exception e)
					{
						out.println(e);
					}
					%>
			</table>
			<%
			if(request.getParameter("sub")!=null)
				{
				 try{
			            String host ="smtp.gmail.com" ;
			            String user = "sarveshnitcsingh@gmail.com";
			            String pass = "";
			            String to = receiver;
			            String from = (String)session.getAttribute("user");
			            String subject = "This is confirmation number for your expertprogramming account. Please insert this number to activate your account.";
			            String messageText = "You are the winner of the bid:" + "=>  " + from;
			            boolean sessionDebug = false;

			            Properties props = System.getProperties();

			            props.put("mail.smtp.starttls.enable", "true");
			            props.put("mail.smtp.host", host);
			            props.put("mail.smtp.port", "587");
			            props.put("mail.smtp.auth", "true");
			            props.put("mail.smtp.starttls.required", "true");

			            java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
			            Session mailSession = Session.getDefaultInstance(props, null);
			            mailSession.setDebug(sessionDebug);
			            Message msg = new MimeMessage(mailSession);
			            msg.setFrom(new InternetAddress(from));
			            InternetAddress[] address = {new InternetAddress(to)};
			            msg.setRecipients(Message.RecipientType.TO, address);
			            msg.setSubject(subject); 
			            msg.setSentDate(new Date());
			            msg.setText(messageText);
			           Transport transport=mailSession.getTransport("smtp");
			           transport.connect(host, user, pass);
			           transport.sendMessage(msg, msg.getAllRecipients());
			           transport.close();
			           //System.out.println("message send successfully");
			           String sqlResult = "UPDATE request SET status= '"+0+"' WHERE  rid = '"+rid+"' ";
			           try{
			           		st.executeUpdate(sqlResult);
			           }
			           catch(Exception e)
			           {
			        	   out.println(e);
			           }
			          	response.sendRedirect("viewRequest.jsp");
			        }catch(Exception ex)
			        {
			        	out.println("<script>alert('Error...')</script>");
			            out.println(ex);
			        }
				}
			con.close();
			%>
		</div>
	</div>
</body>
</html>