package com.test.join;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO 
{
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Connection getConn() 
	{
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(
	                "jdbc:oracle:thin:@localhost:1521:xe", "SCOTT", "TIGER");
			return conn;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean checkDuplicate(String uid) {
		conn = getConn();
		String sql = "SELECT * FROM users WHERE userid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
	            return false;
	        } else {
	        	return true;
	        }
		} catch(SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			closeAll();
		}
		return false;
	}
	
	
	public boolean login(User user)
	{
		String sql = "SELECT * FROM users WHERE userid=? AND userpwd=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2, user.getPwd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			closeAll();
		}
		return false;
	}
	
	public boolean add(User user) {
        conn = getConn();
        String sql = "INSERT INTO users (userid, userpwd) VALUES (?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUid());
            pstmt.setString(2, user.getPwd()); 
            int rowsInserted = pstmt.executeUpdate();
            
            return rowsInserted > 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace(); 
            return false;
        } finally {
            closeAll();
        }
    }
	
	public List<User> getList() {
		conn = getConn();
		try {
			pstmt = conn.prepareStatement("SELECT * FROM users");
			rs = pstmt.executeQuery();
			List<User> list = new ArrayList<>();
			while(rs.next())
			{
				String userid = rs.getString("USERID");
				String userpwd = rs.getString("USERPWD");
				
				User user = new User();
				user.setUid(userid);
				user.setPwd(userpwd);
				list.add(user);
			}
			return list;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public User getDetail(String uid)
	{
		User user = null;
		conn = getConn();
		try {
			pstmt = conn.prepareStatement("SELECT userid, userpwd FROM users WHERE userid = ?");
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				uid = rs.getString("USERID");
				String userpwd = rs.getString("USERPWD");
				
				user = new User();
				user.setUid(uid);
				user.setPwd(userpwd);
			}
			return user;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public boolean updatePwd(User user) {
	    conn = getConn();
	    try {
	        pstmt = conn.prepareStatement("UPDATE users SET userpwd = ? WHERE userid = ?");
	        pstmt.setString(1, user.getPwd());
	        pstmt.setString(2, user.getUid());
	        int rowsUpdated = pstmt.executeUpdate();
	        return rowsUpdated > 0; 
	    } catch (SQLException sqle) {
	        sqle.printStackTrace();
	        return false;
	    } finally {
	        closeAll();
	    }
	}
	
	public boolean delete(String uid)
	{
		conn = getConn();
		try {
            pstmt = conn.prepareStatement("DELETE FROM users WHERE userid = ?");
            pstmt.setString(1, uid);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace(); 
            return false;
        } finally {
            closeAll();
        }
	}

	private void closeAll() {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
