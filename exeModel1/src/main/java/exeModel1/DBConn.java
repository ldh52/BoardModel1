package exeModel1;

import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.SQLException;

	public class DBConn {
	    private static final String DRIVER = "com.mysql.cj.jdbc.Driver"; // MySQL 8.0 이상 버전의 드라이버
	    private static final String URL = "jdbc:mysql://localhost:3306/mydb"; // 데이터베이스 URL
	    private static final String USER = "root"; // 데이터베이스 사용자 이름
	    private static final String PASS = "your_password"; // 데이터베이스 비밀번호

	    public static Connection getConnection() throws SQLException, ClassNotFoundException {
	        Class.forName(DRIVER); // JDBC 드라이버 로드
	        return DriverManager.getConnection(URL, USER, PASS); // 데이터베이스 연결
	    }
	}