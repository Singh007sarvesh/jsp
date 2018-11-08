<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	session = request.getSession();
	String itemid = request.getParameter("rid");
	String bid = request.getParameter("bid");
	if(session.getAttribute("user")==null){
		response.sendRedirect("home.jsp");
	}
	else if(session.getAttribute("user")!=null){
		session.setAttribute("rid",itemid);
		session.setAttribute("bid", bid);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Session</title>
</head>
<body>
		<%
			if(session.getAttribute("bid")!=null)
				response.sendRedirect("/RBidding/buyer/ViewBid.jsp");
			else
			response.sendRedirect("SellerBid.jsp"); 
			%>
</body>
</html>