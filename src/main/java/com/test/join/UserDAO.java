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
	// 데이터베이스 연결 정보 (외부 설정 파일이나 환경 변수에서 읽어오는 것이 더 안전합니다)
    private String driver = "oracle.jdbc.OracleDriver"; 
    private String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
    private String dbid = "SCOTT"; 
    private String dbpw = "TIGER";

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 데이터베이스 연결을 얻는 메서드 
    private Connection getConn() {
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, dbid, dbpw);
            return conn;
        } catch (Exception e) {
            e.printStackTrace(); // 로그 출력 혹은 로깅 프레임워크 사용 권장
            return null;
        }
    }
	
    // 아이디 중복 체크 
	public boolean checkDuplicate(String uid) {
		conn = getConn();
		String sql = "SELECT * FROM users WHERE userid=?";
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
	
	// 로그인 처리
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

	// 사용자 추가 (회원가입)
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
	
	// 모든 사용자 목록 조회
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
			return null;
		}finally {
			closeAll();
		}
	}
	
	// 특정 사용자 정보 조회
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
			return null;
		}finally {
			closeAll();
		}
		return null;
	}
	
	// 비밀번호 변경
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
			return false;
		}finally {
			closeAll();
		}
	}
	
	// 사용자 삭제
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
			return false;
		}finally {
			closeAll();
		}
	}

	public boolean saveMember(MemberVO m) {
	    String sqlMember = "INSERT INTO member(userid, pwd, gender, age, birth, intro) VALUES (?, ?, ?, ?, ?, ?)";
	    String sqlHobby = "INSERT INTO hobby(userid, hobbycode) VALUES (?, (SELECT code FROM hobbycode WHERE hobby=?))";

	    conn = getConn();
	    try {
	        conn.setAutoCommit(false); // Start transaction

	        pstmt = conn.prepareStatement(sqlMember);
	        pstmt = conn.prepareStatement(sqlMember);

	        pstmt.setString(1, m.getUid());       // Set userid
	        pstmt.setString(2, m.getPwd());      // Set password (ensure it's hashed and salted)
	        pstmt.setString(3, m.getGender());    // Set gender
	        pstmt.setInt(4, m.getAge());          // Set age
	        pstmt.setDate(5, m.getBirth());       // Set birth date
	        pstmt.setString(6, m.getIntro());     // Set introduction

	        int memRows = pstmt.executeUpdate(); 

	        pstmt = conn.prepareStatement(sqlHobby);
	        int hobbyRows = 0;
	        for (String hobby : m.getHobby()) {
	            pstmt.setString(1, m.getUid());
	            pstmt.setString(2, hobby);
	            hobbyRows += pstmt.executeUpdate();
	        }

	        if (m.getHobby().length + 1 == memRows + hobbyRows) {
	            conn.commit(); // Commit transaction on success
	            return true;
	        } else {
	            conn.rollback(); // Rollback on failure
	            // Log error or throw exception with appropriate message
	            return false;
	        }
	    } catch (SQLException sqle) {
	        try {
	            conn.rollback(); // Rollback on exception
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return false;
	    } finally {
	        try {
	            conn.setAutoCommit(true); // Reset auto-commit
	        } catch (SQLException e) {
	        	e.printStackTrace();
	        }
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