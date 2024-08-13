package com.test.model1board;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO 
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

   public int addBoard(Board b) 
   {
      conn = getConn();
      String sql = "INSERT INTO board1(bnum,title,author,contents,rdate, hit) "
               + "VALUES(board1_num_seq.NEXTVAL, ?,?,?,?,0) "
               + "RETURNING bnum INTO ?";
      try {
         CallableStatement cstmt = conn.prepareCall("{call " + sql + "}");
         
         cstmt.setString(1, b.getTitle());
         cstmt.setString(2, b.getAuthor());
         cstmt.setString(3, b.getContents());
         cstmt.setDate(4, b.getRdate());
         
         cstmt.registerOutParameter(5, Types.INTEGER);
         
         int rows = cstmt.executeUpdate();
         int bnum = cstmt.getInt(5);

         return bnum ;
         
      }catch(SQLException sqle) {
         sqle.printStackTrace();
      }finally {
         closeAll();
      }
      return 0;
   }
   
   public Board getBoard(int bnum) 
   {
      conn = getConn();
      String sql = "SELECT * FROM board1 WHERE bnum=?";
      try {
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, bnum);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            Board b = new Board();
            b.setBnum(rs.getInt("BNUM"));
            b.setTitle(rs.getString("TITLE"));
            b.setAuthor(rs.getString("AUTHOR"));
            b.setContents(rs.getString("CONTENTS"));
            b.setRdate(rs.getDate("RDATE"));
            b.setHit(rs.getInt("HIT"));
            return b;
         }
      }catch(SQLException sqle) {
         sqle.printStackTrace();
      }finally {
         closeAll();
      }
      return null;
   }
   
   public List<Board> getBoardList() 
   {
      conn = getConn();
      String sql = "SELECT * FROM board1 ORDER BY bnum";
      try {
         pstmt = conn.prepareStatement(sql);

         rs = pstmt.executeQuery();
         List<Board> list = new ArrayList<Board>();
         while(rs.next()) {
            Board b = new Board();
            b.setBnum(rs.getInt("BNUM"));
            b.setTitle(rs.getString("TITLE"));
            b.setAuthor(rs.getString("AUTHOR"));
            b.setContents(rs.getString("CONTENTS"));
            b.setRdate(rs.getDate("RDATE"));
            b.setHit(rs.getInt("HIT"));
            list.add(b);
         }
         return list;
      }catch(SQLException sqle) {
         sqle.printStackTrace();
      }finally {
         closeAll();
      }
      return null;
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