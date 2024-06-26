package pack.staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.coach.CoachBean;

public class StaffMgr {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	DataSource ds;
	 
	
	public StaffMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");			
		} catch (Exception e) {
			System.out.println("DB 연결 에러 " + e);
		}
	}
	
	// 모든 스태프 정보 불러오기
	public ArrayList<StaffBean> getStaffAll(String teamcode) {
	    ArrayList<StaffBean> list = new ArrayList<StaffBean>();
	    
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM staff where staff_teamcode=? order by staff_role asc";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, teamcode);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            StaffBean staff = new StaffBean();
	            staff.setCode(rs.getInt("staff_code"));
	            staff.setName(rs.getString("staff_name"));
	            staff.setTeamcode(rs.getString("staff_teamcode"));
	            staff.setNation(rs.getString("staff_nation"));
	            staff.setRole(rs.getString("staff_role"));
	            staff.setIbdan(rs.getString("staff_ibdan"));
	            list.add(staff);
	        }
	    } catch (Exception e) {
	        System.out.println("getStaffAll err: " + e.getMessage());
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	           
	        }
	    }
	    return list;
	}

	// 스태프 정보 추가하기
	
	public boolean staffInsert(StaffBean sbean) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String Sql = "insert into staff(staff_code,staff_name,staff_teamcode,staff_nation,staff_role,staff_ibdan)" + " values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(Sql);
			pstmt.setInt(1, sbean.getCode());
			pstmt.setString(2, sbean.getName());
			pstmt.setString(3, sbean.getTeamcode());
			pstmt.setString(4, sbean.getNation());
			pstmt.setString(5, sbean.getRole());
			pstmt.setString(6, sbean.getIbdan());
			if(pstmt.executeUpdate() > 0) b = true; 
			
		} catch (Exception e) {
			System.out.println("insertData err: " + e.getMessage());
	        e.printStackTrace();
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
	
	// 스태프 정보 가져오기
	 public StaffBean getStaff(String code, String teamcode) {
		  StaffBean sBean = null;
		  try {
			 conn = ds.getConnection();
			 String sql = "select * from staff where staff_code=? and staff_teamcode=?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, code);
			 pstmt.setString(2, teamcode);
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 sBean = new StaffBean();
				 
				 sBean.setCode(rs.getInt("staff_code"));
				 sBean.setName(rs.getString("staff_name"));
				 sBean.setTeamcode(rs.getString("staff_teamcode"));
				 sBean.setNation(rs.getString("staff_nation"));
				 sBean.setRole(rs.getString("staff_role"));
				 sBean.setIbdan(rs.getString("staff_ibdan"));
			 }
		} catch (Exception e) {
			System.out.println("staffUpdate err : " + e);
		}finally {
	         try {
	             if(rs != null) rs.close();
	             if(pstmt != null) pstmt.close();
	             if(conn != null) conn.close();
	          } catch (Exception e2) { 
	        	  
	          }

		}
		  return sBean;
	  }
	// 스태프 정보 수정하기
	 public boolean staffUpdate(StaffBean sBean) {
	      boolean bool = false;
	      
	      try {
	         String sql = "update staff set staff_name=?,staff_teamcode=?,staff_nation=?,staff_role=?,staff_ibdan=? where staff_code=?";
	         
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, sBean.getName());
	         pstmt.setString(2, sBean.getTeamcode());
	         pstmt.setString(3, sBean.getNation());
	         pstmt.setString(4, sBean.getRole());
	         pstmt.setString(5, sBean.getIbdan());
	         pstmt.setInt(6, sBean.getCode());
	         
	         if (pstmt.executeUpdate() > 0) bool = true;
	         
	      } catch (Exception e) {
	         System.out.println("staffUpdate err : " + e);
	      } finally {
	         try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(conn != null) conn.close();
	         } catch (Exception e2) { }
	      }
	      
	      return bool;
	   }
	   
	 // 스태프 정보 삭제하기
	   public boolean staffDelete(int code) {
	      boolean bool = false;
	      
	      try {
	         String sql = "delete from staff where staff_code=?";
	         
	         conn = ds.getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, code);
	         
	         if(pstmt.executeUpdate() > 0) bool = true;
	         
	      } catch (Exception e) {
	         System.out.println("staffDelete err : " + e);
	      } finally {
	         try {
	            if(rs != null) rs.close();
	            if(pstmt != null) pstmt.close();
	            if(conn != null) conn.close();
	         } catch (Exception e2) { }
	      }
	      
	      return bool;
	   }
	   
	   public ArrayList<StaffBean> getStaffByCategory(String category, String teamcode) {
	        ArrayList<StaffBean> list = new ArrayList<>();
	        try {
	            conn = ds.getConnection();
	            String sql = "SELECT * FROM staff WHERE staff_role=? and staff_teamcode=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, category);
	            pstmt.setString(2, teamcode);
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                StaffBean bean = new StaffBean();
	                bean.setCode(rs.getInt("staff_code"));
	                bean.setName(rs.getString("staff_name"));
	                bean.setTeamcode(rs.getString("staff_teamcode"));
	                bean.setNation(rs.getString("staff_nation"));
	                bean.setRole(rs.getString("staff_role"));
	                bean.setIbdan(rs.getString("staff_ibdan"));
	                list.add(bean);
	            }
	        } catch (Exception e) {
	            System.out.println("getCoachesByCategory() 에러: " + e);
	        } finally {
	            try {
	                if (rs != null) rs.close();
	                if (pstmt != null) pstmt.close();
	                if (conn != null) conn.close();
	            } catch (Exception e2) {
	                // Handle exception
	            }
	        }
	        return list;
	    }
	   
}
	 
	 
	 
	
	
	