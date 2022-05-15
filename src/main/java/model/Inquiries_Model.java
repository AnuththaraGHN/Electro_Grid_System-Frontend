package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import db_connection.DB;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class Inquiries_Model {

	private String res;
	
	public String getRes() {
		return res;
	}

	public void setRes(String res) {
		this.res = res;
	}

	public String getInquiries() {
		PreparedStatement ps;
		String data="";
		
		try {
			
			Connection conn = DB.getConn();
			ps = conn.prepareStatement("SELECT * FROM inquiries");
			
			ResultSet res_Set = ps.executeQuery();
			
			data = "<table>"
		            +"<tr>"
		            +"<th style='border-style: dotted;'>ID</th>"
	                +"<th style='border-style: dotted;'>Account ID</th>"
	                +"<th style='border-style: dotted;'>Customer Name</th>"
	                +"<th style='border-style: dotted;'>Customer Id</th>"
	                +"<th style='border-style: dotted;'>Customer Phone</th>"
	                +"<th style='border-style: dotted;'>NIC</th>"
	                +"<th style='border-style: dotted;'>Customer Email</th>"
	                +"<th style='border-style: dotted;'>Description</th>"
	                +"<th style='border-style: dotted;'>Type</th>"
	                +"<th style='border-style: dotted;'>Date</th>"
	                +"<th style='border-style: dotted;'>Edit/Delete</th>"
	                +"</tr>";
			
			while (res_Set.next()) {
				
				String button = "<button type='button' onclick='edit("+res_Set.getString(1)+")' class='btn btn-primary'>Edit</button><br><button type='button' onclick='deletes("+res_Set.getString(1)+")' class='btn btn-warning'>Delete</button>";
				
				data = data+"<tr><td style='border-style: dotted;'>"+res_Set.getString(1)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(2)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(3)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(4)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(5)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(6)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(7)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(8)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(9)+"</td>"
						+ "<td style='border-style: dotted;'>"+res_Set.getString(10)+"</td>"
						+ "<td style='border-style: dotted;'>"+button+"</td>"
					  + "</tr>";
				
			}
			
			ps.close();
			conn.close();
			
		}catch (ClassNotFoundException | SQLException  e) {

			System.out.println(e.getMessage());
		}
		
		return data+"</table>";
	}
	
	public void addInquiries(String account_id,String name,String c_id,String c_phone,String c_nic,String email,String description,String type,String date) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("INSERT into inquiries (account_id,name,c_id,c_phone,c_nic,email,description,type,date) values (?,?,?,?,?,?,?,?,?)");
			ps.setString(1, account_id);
			ps.setString(2, name);
			ps.setString(3, c_id);
			ps.setString(4, c_phone);
			ps.setString(5, c_nic);
			ps.setString(6, email);
			ps.setString(7, description);
			ps.setString(8, type);
			ps.setString(9, date);
			ps.execute();
			ps.close();
			conn.close();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public void editInquiries(int id,String account_id,String name,String c_id,String c_phone,String c_nic,String email,String description,String type,String date) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
				ps = conn.prepareStatement("UPDATE inquiries SET account_id=?,name=?,c_id=?,c_phone=?,c_nic=?,email=?,description=?,type=?,date=? where id=?");
				ps.setString(1, account_id);
				ps.setString(2, name);
				ps.setString(3, c_id);
				ps.setString(4, c_phone);
				ps.setString(5, c_nic);
				ps.setString(6, email);
				ps.setString(7, description);
				ps.setString(8, type);
				ps.setString(9, date);
				ps.setInt(10,id);
				ps.execute();
				ps.close();
				conn.close();
				setRes("Done");
				
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}

	public JSONObject getOneInquiry(int id) {
		Connection connection;
		PreparedStatement ps;
		JSONObject json = new JSONObject();
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("SELECT * FROM inquiries where id=?");
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			while(rs.next())
			{
				json.put("id", rs.getInt(1));
				json.put("account_id", rs.getString(2));
				json.put("name", rs.getString(3));
				json.put("c_id", rs.getString(4));
				json.put("c_phone", rs.getString(5));
				json.put("c_nic", rs.getString(6));
				json.put("email", rs.getString(7));
				json.put("description", rs.getString(8));
				json.put("type", rs.getString(9));
				json.put("date", rs.getString(10));
			}
			
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("unsuccess");
		}
		return json;
	}

	
	public void deleteInquiries(int id) {
		PreparedStatement ps;
		
		try {
			Connection conn = DB.getConn();
			
			ps = conn.prepareStatement("DELETE FROM inquiries WHERE id=?");
			ps.setInt(1, id);
			ps.execute();
			setRes("Done");
		
		}catch (ClassNotFoundException | SQLException  e) {
			setRes("Error");
		}
	}
	
}
