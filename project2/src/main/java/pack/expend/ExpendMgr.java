package pack.expend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ExpendMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public ExpendMgr() {
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
			String sql = "select column_name from information_schema.columns where table_name='expend'";
			
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
	
	public ArrayList<Integer> getExpend(ArrayList<String> colName, String sdate, String edate, String teamcode) {
		ArrayList<Integer> list = new ArrayList<Integer>();

		try {
			conn = ds.getConnection();
			
			for(int i = 0; i < colName.size() - 1; i++) {
				String sql = "select sum(" + colName.get(i) +") from expend where expend_teamcode=? and expend_date>=? and expend_date<=?";  // SQL injection
				pstmt = conn.prepareStatement(sql);
				// 칼럼명은 바인딩 불가!
				//pstmt.setString(1, colName.get(i));
				pstmt.setString(1, teamcode);
				pstmt.setString(2, sdate);
				pstmt.setString(3, edate);
				rs = pstmt.executeQuery();
				if(rs.next()) list.add(rs.getInt(1));
			}
		} catch (Exception e) {
			System.out.println("getExpend() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}

		return list;
	}
	
	public ArrayList<ExpendBean> getExpendAll(String sdate, String edate, String teamcode) {
		ArrayList<ExpendBean> list = new ArrayList<ExpendBean>();
		
		try {
			conn = ds.getConnection();
			String sql;
			if (sdate.isEmpty() || edate.isEmpty()) {
				sql = "select * from expend where expend_teamcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, teamcode);
			} else {
				sql = "select * from expend where expend_date >= ? and expend_date <= ? and expend_teamcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				pstmt.setString(3, teamcode);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ExpendBean dto = new ExpendBean();
				dto.setCode(rs.getInt("expend_code"));
				dto.setTeamcode(rs.getString("expend_teamcode"));
				dto.setDate(rs.getString("expend_date"));
				dto.setBriefs(rs.getString("expend_briefs"));
				dto.setPybuy(rs.getInt("expend_pybuy"));
				dto.setTrans(rs.getInt("expend_trans"));
				dto.setEat(rs.getInt("expend_eat"));
				dto.setMaintain(rs.getInt("expend_maintain"));
				dto.setCosalary(rs.getInt("expend_cosalary"));
				dto.setHcsalary(rs.getInt("expend_hcsalary"));
				dto.setStsalary(rs.getInt("expend_stsalary"));
				dto.setTraining(rs.getInt("expend_training"));
				dto.setMkting(rs.getInt("expend_mkting"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getExpendAll err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// Handle exception
			}
		}
		return list;
	}

	
	   // 새로운 메서드 추가
	 public boolean expendInsert(ExpendBean ebean) {
	        boolean b = false;
	        try {
	            conn = ds.getConnection();
	            String sql = "INSERT INTO expend (expend_teamcode, expend_date, expend_briefs, expend_pybuy, expend_trans, expend_eat, expend_maintain, expend_cosalary, expend_hcsalary, expend_stsalary, expend_training, expend_mkting) VALUES (?, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, ebean.getTeamcode());
	            pstmt.setString(2, ebean.getBriefs());
	            pstmt.setInt(3, ebean.getPybuy());
	            pstmt.setInt(4, ebean.getTrans());
	            pstmt.setInt(5, ebean.getEat());
	            pstmt.setInt(6, ebean.getMaintain());
	            pstmt.setInt(7, ebean.getCosalary());
	            pstmt.setInt(8, ebean.getHcsalary());
	            pstmt.setInt(9, ebean.getStsalary());
	            pstmt.setInt(10, ebean.getTraining());
	            pstmt.setInt(11, ebean.getMkting());
	            if (pstmt.executeUpdate() > 0) {
	                b = true;
	            }
	        } catch (Exception e) {
	            System.out.println("expendInsert err: " + e);
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
    
	 public boolean updateExpend(ExpendBean expend) {
	        boolean b = false;
	        try {
	            conn = ds.getConnection();
	            String sql = "UPDATE expend SET expend_teamcode = ?, expend_briefs = ?, expend_pybuy = ?, expend_trans = ?, expend_eat = ?, expend_maintain = ?, expend_cosalary = ?, expend_hcsalary = ?, expend_stsalary = ?, expend_training = ?, expend_mkting = ? WHERE expend_code = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, expend.getTeamcode());
	            pstmt.setString(2, expend.getBriefs());
	            pstmt.setInt(3, expend.getPybuy());
	            pstmt.setInt(4, expend.getTrans());
	            pstmt.setInt(5, expend.getEat());
	            pstmt.setInt(6, expend.getMaintain());
	            pstmt.setInt(7, expend.getCosalary());
	            pstmt.setInt(8, expend.getHcsalary());
	            pstmt.setInt(9, expend.getStsalary());
	            pstmt.setInt(10, expend.getTraining());
	            pstmt.setInt(11, expend.getMkting());
	            pstmt.setInt(12, expend.getCode());
	            if (pstmt.executeUpdate() > 0) {
	                b = true;
	            }
	        } catch (Exception e) {
	            System.out.println("updateExpend err: " + e);
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

    public boolean deleteExpend(int code) {
        boolean b = false;
        try {
            conn = ds.getConnection();
            String sql = "DELETE FROM expend WHERE expend_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            if (pstmt.executeUpdate() > 0) {
                b = true;
            }
        } catch (Exception e) {
            System.out.println("deleteExpend err: " + e);
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
    
    public ExpendBean getExpendById(int code, String teamcode) {
    	ExpendBean dto = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM expend WHERE expend_code=? and expend_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new ExpendBean();
                dto.setCode(rs.getInt("expend_code"));
                dto.setTeamcode(rs.getString("expend_teamcode"));
                dto.setBriefs(rs.getString("expend_briefs"));
                dto.setPybuy(rs.getInt("expend_pybuy"));
                dto.setTrans(rs.getInt("expend_trans"));
                dto.setEat(rs.getInt("expend_eat"));
                dto.setMaintain(rs.getInt("expend_maintain"));
                dto.setCosalary(rs.getInt("expend_cosalary"));
                dto.setHcsalary(rs.getInt("expend_hcsalary"));
                dto.setStsalary(rs.getInt("expend_stsalary"));
                dto.setTraining(rs.getInt("expend_training"));
                dto.setMkting(rs.getInt("expend_mkting"));
            }
        } catch (Exception e) {
            System.out.println("getExpendById err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return dto;
    }
    
    public ArrayList<ExpendBean> getExpendByOption(String option, String teamcode) {
        ArrayList<ExpendBean> list = new ArrayList<ExpendBean>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM expend WHERE ";
            switch (option) {
                case "선수 구매":
                    sql += "expend_pybuy > 0 and expend_teamcode=?";
                    break;
                case "교통비":
                    sql += "expend_trans > 0 and expend_teamcode=?";
                    break;
                case "식비":
                    sql += "expend_eat > 0 and expend_teamcode=?";
                    break;
                case "유지보수":
                    sql += "expend_maintain > 0 and expend_teamcode=?";
                    break;
                case "코치 급여":
                    sql += "expend_cosalary > 0 and expend_teamcode=?";
                    break;
                case "감독 급여":
                    sql += "expend_hcsalary > 0 and expend_teamcode=?";
                    break;
                case "스태프 급여":
                    sql += "expend_stsalary > 0 and expend_teamcode=?";
                    break;
                case "훈련":
                    sql += "expend_training > 0 and expend_teamcode=?";
                    break;
                case "마케팅":
                    sql += "expend_mkting > 0 and expend_teamcode=?";
                    break;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	ExpendBean dto = new ExpendBean();
                dto.setCode(rs.getInt("expend_code"));
                dto.setTeamcode(rs.getString("expend_teamcode"));
                dto.setBriefs(rs.getString("expend_briefs"));
                dto.setDate(rs.getString("expend_date"));
                dto.setPybuy(rs.getInt("expend_pybuy"));
                dto.setTrans(rs.getInt("expend_trans"));
                dto.setEat(rs.getInt("expend_eat"));
                dto.setMaintain(rs.getInt("expend_maintain"));
                dto.setCosalary(rs.getInt("expend_cosalary"));
                dto.setHcsalary(rs.getInt("expend_hcsalary"));
                dto.setStsalary(rs.getInt("expend_stsalary"));
                dto.setTraining(rs.getInt("expend_training"));
                dto.setMkting(rs.getInt("expend_mkting"));
                
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getExpendByOption err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return list;
    }
}
