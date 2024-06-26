package pack.injury;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.coach.CoachBean;

public class InjuryMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public InjuryMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	public ArrayList<InjuryBean> getAllInjuries() {
        ArrayList<InjuryBean> list = new ArrayList<InjuryBean>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM injury";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                InjuryBean dto = new InjuryBean();
                dto.setBn(rs.getInt("injury_bn"));
                dto.setPart(rs.getString("injury_part"));
                dto.setState(rs.getString("injury_state"));
                dto.setDate(rs.getString("injury_date"));
                dto.setDoctor(rs.getString("injury_doctor"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getAllInjuries err: " + e);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return list;
    }
	
	public boolean addInjury(InjuryBean injury) {
	    boolean isSuccess = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "INSERT INTO injury (injury_bn, injury_part, injury_state, injury_date, injury_doctor) VALUES (?, ?, ?, ?, ?)";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, injury.getBn());
	        pstmt.setString(2, injury.getPart());
	        pstmt.setString(3, injury.getState());
	        pstmt.setString(4, injury.getDate());
	        pstmt.setString(5, injury.getDoctor());
	        pstmt.executeUpdate();
	        isSuccess = true;
	    } catch (Exception e) {
	        System.out.println("addInjury err: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return isSuccess;
	}
	
	public boolean isInjuryExist(int bn) {
	    boolean isExist = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT COUNT(*) FROM injury WHERE injury_bn = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, bn);
	        rs = pstmt.executeQuery();
	        if (rs.next() && rs.getInt(1) > 0) {
	            isExist = true;
	        }
	    } catch (Exception e) {
	        System.out.println("isInjuryExist err: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return isExist;
	}
	
	public boolean updateInjury(InjuryBean injury) {
	    boolean isSuccess = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "UPDATE injury SET injury_part = ?, injury_state = ?, injury_date = ?, injury_doctor = ? WHERE injury_bn = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, injury.getPart());
	        pstmt.setString(2, injury.getState());
	        pstmt.setString(3, injury.getDate());
	        pstmt.setString(4, injury.getDoctor());
	        pstmt.setInt(5, injury.getBn());
	        int rowsUpdated = pstmt.executeUpdate();
	        if (rowsUpdated > 0) {
	            isSuccess = true;
	        }
	    } catch (Exception e) {
	        System.out.println("updateInjury err: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return isSuccess;
	}
	
	public InjuryBean getInjuryByBn(int bn) {
	    InjuryBean injury = null;
	    try {
	        conn = ds.getConnection();
	        String sql = "SELECT * FROM injury WHERE injury_bn = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, bn);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            injury = new InjuryBean();
	            injury.setBn(rs.getInt("injury_bn"));
	            injury.setPart(rs.getString("injury_part"));
	            injury.setState(rs.getString("injury_state"));
	            injury.setDate(rs.getString("injury_date"));
	            injury.setDoctor(rs.getString("injury_doctor"));
	        }
	    } catch (Exception e) {
	        System.out.println("getInjuryByBn err: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return injury;
	}

	public boolean deleteInjury(int bn) {
	    boolean isSuccess = false;
	    try {
	        conn = ds.getConnection();
	        String sql = "DELETE FROM injury WHERE injury_bn = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, bn);
	        int rowsDeleted = pstmt.executeUpdate();
	        if (rowsDeleted > 0) {
	            isSuccess = true;
	        }
	    } catch (Exception e) {
	        System.out.println("deleteInjury err: " + e);
	        e.printStackTrace();
	    } finally {
	        try {
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	    return isSuccess;
	}

}