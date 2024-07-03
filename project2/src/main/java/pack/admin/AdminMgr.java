package pack.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public AdminMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("AdminMgr DB 연결 실패 : " + e);
		}
	}
	
	// 기존 관리자 여부 체크
	public boolean adminCheck(String id, String passwd, String teamcode) {
 		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "select * from admin where admin_id = ? and admin_passwd = ? and admin_teamcode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.setString(3, teamcode);
			rs = pstmt.executeQuery();			
			if (rs.next()) {
				b = true;
			}
		} catch (Exception e) {
		System.out.println("adminCheck error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return b;
	}
	
	// 해당 ID 관리자 정보 다 가져오기
	public AdminDto getAdmin(String id) {
		AdminDto aDto = null;
		try {
			conn = ds.getConnection();
			String sql = "select * from admin where admin_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();		
			if (rs.next()) {
				aDto = new AdminDto();
				aDto.setId(rs.getString("admin_id"));
				aDto.setPasswd(rs.getString("admin_passwd"));
				aDto.setTeamcode(rs.getString("admin_teamcode"));
			}
		} catch (Exception e) {
			System.out.println("getAdmin error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return aDto;
	}

}
