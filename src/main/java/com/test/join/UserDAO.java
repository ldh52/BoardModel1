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
		String sql = "SELECT * FROM users WHERE userid=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return false;
			}else {
				return true;
			}
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	
	public boolean login(User user) {
		String sql = "SELECT * FROM users WHERE userid=? AND userpwd=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUid());
			pstmt.setString(2,  user.getPwd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	

	public boolean add(User u) {
		String sql = "INSERT INTO users VALUES(?,?)";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, u.getUid());
			pstmt.setString(2, u.getPwd());
			int rows = pstmt.executeUpdate();
			
			return rows>0;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	
	public List<User> getList()
	{
		String sql = "SELECT * FROM users";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			List<User> list = new ArrayList<>();
			while(rs.next()) {
				String userid = rs.getString("USERID");
				String userpwd = rs.getString("USERPWD");
				list.add(new User(userid, userpwd));
			}
			return list;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	

	public User getDetail(String uid) {
		String sql = "SELECT * FROM users WHERE userid=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String userid = rs.getString("USERID");
				String userpwd = rs.getString("USERPWD");
				return new User(userid, userpwd);
			}
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public boolean updatePwd(User user) {
		String sql = "UPDATE users SET userpwd=? WHERE userid=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getPwd());
			pstmt.setString(2, user.getUid());
			int rows = pstmt.executeUpdate();
			
			return rows>0;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	
	public boolean delete(String uid) {
		String sql = "DELETE FROM users WHERE userid=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uid);
			int rows = pstmt.executeUpdate();
			return rows>0;
		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}

	public boolean saveMember(MemberVO m) {
		String sql = "INSERT INTO member(userid,pwd,gender,age,birth,intro) "
				   + "VALUES(?,?,?,?,?,?)";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m.getUid());
			pstmt.setString(2,  m.getPwd());
			pstmt.setString(3, m.getGender());
			pstmt.setInt(4, m.getAge());
			pstmt.setDate(5, m.getBirth());
			pstmt.setString(6, m.getIntro());
			
			int mem_rows = pstmt.executeUpdate();

			String[] hobbies = m.getHobby();
			sql = "INSERT INTO hobby(userid, hobbycode) VALUES "
				+ "( "
				+ "    ?, "
				+ "    (SELECT code FROM hobbycode WHERE hobby=?) "
				+ ")";
			pstmt = conn.prepareStatement(sql);
			int hobby_rows = 0;
			for(int i=0;i<hobbies.length;i++) {
				pstmt.setString(1, m.getUid());
				pstmt.setString(2, hobbies[i]);
				hobby_rows += pstmt.executeUpdate();
			}
			return hobbies.length + 1 == mem_rows + hobby_rows;

		}catch(SQLException sqle) {
			sqle.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	
	public boolean saveMember2(MemberVO m) {
		String sql = "INSERT INTO member(userid,pwd,gender,age,birth,intro) "
				   + "VALUES(?,?,?,?,?,?)";
		conn = getConn();
		
		try {
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, m.getUid());
			pstmt.setString(2,  m.getPwd());
			pstmt.setString(3, m.getGender());
			pstmt.setInt(4, m.getAge());
			pstmt.setDate(5, m.getBirth());
			pstmt.setString(6, m.getIntro());
			
			int mem_rows = pstmt.executeUpdate();

			String[] hobbies = m.getHobby();
			sql = "INSERT INTO hobby(userid, hobbycode) VALUES "
				+ "( "
				+ "    ?, "
				+ "    (SELECT code FROM hobbycode WHERE hobby=?) "
				+ ")";
			pstmt = conn.prepareStatement(sql);
			int hobby_rows = 0;
			for(int i=0;i<hobbies.length;i++) {
				pstmt.setString(1, m.getUid());
				pstmt.setString(2, hobbies[i]);
				hobby_rows += pstmt.executeUpdate();
			}
			boolean saved = hobbies.length + 1 == mem_rows + hobby_rows;
			if(saved) {
				conn.commit();
			}
			return saved;

		}catch(SQLException sqle) {
			try {
				conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			sqle.printStackTrace();
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			closeAll();
		}
		return false;
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
