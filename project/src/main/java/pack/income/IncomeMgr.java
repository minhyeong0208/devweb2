package pack.income;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class IncomeMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public IncomeMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	public ArrayList<String> getColumn() {
		ArrayList<String> colName = new ArrayList<String>();
		
		try {
			String sql = "select column_name from information_schema.columns where table_name='income'";
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//System.out.println(rs.getString(1));;
				colName.add(rs.getString(1));
			}
		} catch (Exception e) {
			System.out.println("getColumn() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return colName;
	}
	
	public ArrayList<Integer> getIncome(ArrayList<String> colName, String sdate, String edate) {
		ArrayList<Integer> list = new ArrayList<Integer>();

		try {
			conn = ds.getConnection();
			
			for(int i = 0; i < colName.size() - 1; i++) {
				String sql = "select sum(" + colName.get(i) +") from income where income_date>=? and income_date<=?";  // SQL injection
				pstmt = conn.prepareStatement(sql);
				//pstmt.setString(1, colName.get(i));
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				rs = pstmt.executeQuery();
				if(rs.next()) list.add(rs.getInt(1));
			}
		} catch (Exception e) {
			System.out.println("getIncome() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}

		return list;
	}
}
 