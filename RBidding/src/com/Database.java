package com;
import java.sql.*;

public class Database {
		public static Connection con()throws Exception
	  	{
			
			Connection connection;
			Statement statement;
	  		Class.forName("com.mysql.jdbc.Driver"); 
	  		connection=DriverManager.getConnection("jdbc:mysql://localhost/revbid","root","sarvesh");
	  		statement=connection.createStatement();
	  		return connection;
	  	}
		public static Statement st()throws Exception {
			Statement statement;
			statement = Database.con().createStatement();
			return null;
		}

}
