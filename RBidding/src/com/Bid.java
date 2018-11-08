package com;
import java.sql.*;
import java.text.SimpleDateFormat;
import com.Database;
import java.util.Date;
import java.util.Locale;

public class Bid //Creating class for bid
{	
	   //List of Attributes of Bid Class
	    public String itemId;
	    public String itemName;
	    public int bidAmount;
	    private String startTime;
	    private String closeTime;
	    public String email;
	    public Connection conn;
	    public Statement st;
	   
	   public Bid() {
		}
	public Bid(String rId, String cemail, String amount)throws Exception //constructor function to initiallize the class attributes 
	   {
	        this.itemId = rId;
	        this.email= cemail;
	        this.conn = Database.con(); //variable to store connection to the db.
	        this.st=this.conn.createStatement();
	        int Rid = Integer.parseInt(this.itemId);
	        String query = "SELECT * FROM request WHERE rid = '"+Rid+"'";
	        try
			{
				ResultSet resultSet = st.executeQuery(query);
				resultSet.next();
		        this.itemName = resultSet.getString("item");
		        this.startTime = resultSet.getString("stime");
		        this.closeTime = resultSet.getString("ctime");
		        String temp=amount;
		        if (temp != null)
		        {
		            this.bidAmount= Integer.parseInt(temp);
		        }
			}
	        catch (Exception e)
			{
				e.printStackTrace();
			}
		}	  
	    public boolean updateBid(String amt) //function to update bid when entered  amount is greater then bid amount.
	    {	
	    	int amount = Integer.parseInt(amt);
	    	int Rid = Integer.parseInt(this.itemId);
	    	int amont =0;
	    	try {
	    		amont = this.bidAmount;
	    	}
	    	catch(Exception e) {
	    		e.printStackTrace();
	    	}
	        if(this.bidAmount==0 || amount<amont)
	        {
	        	Date dateobj = new Date();
	        	SimpleDateFormat simpleDateFormat = 
	                    new SimpleDateFormat("yyyy-MM-dd",
	                            Locale.ENGLISH);
	        	String curdate = simpleDateFormat.format(dateobj);
	            String cemail= this.email;
	            System.out.println(this.itemName+" "+this.bidAmount); 
	            String query = "insert into revparticipant(rid,email,Date,amount)values('"+Rid+"','"+cemail+"','"+curdate+"','"+amount+"')";
	            System.out.println(this.itemName);
	            try
				{
					this.st.executeUpdate(query);
					return true;
				}
				catch(Exception e){
					System.out.println("Data Not Inserted");
					return false;
				}
	        }
	        return false;
	    }
	    public String getItemName() {
	    	return this.itemName;
	    }
	    public int getBidAmount() {
	    	return this.bidAmount;
	    }
	    public String getemail() {
	    	return this.email;
	    }
	}