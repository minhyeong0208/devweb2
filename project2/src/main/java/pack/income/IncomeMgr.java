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
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
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
	
	public ArrayList<Integer> getIncome(ArrayList<String> colName, String sdate, String edate, String teamcode) {
		ArrayList<Integer> list = new ArrayList<Integer>();

		try {
			conn = ds.getConnection();

			for (int i = 0; i < colName.size() - 1; i++) {
				String sql = "select sum(" + colName.get(i) + ") from income where income_date>=? and income_date<=? and income_teamcode=?";
																														
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, colName.get(i));
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				pstmt.setString(3, teamcode);
				rs = pstmt.executeQuery();
				if (rs.next())
					list.add(rs.getInt(1));
			}
		} catch (Exception e) {
			System.out.println("getIncome() err : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}

		return list;
	}
	
	public ArrayList<IncomeBean> getIncomeAll(String sdate, String edate, String teamcode) {
		ArrayList<IncomeBean> list = new ArrayList<IncomeBean>();
		
		try {
			conn = ds.getConnection();
			String sql;
			if (sdate.isEmpty() || edate.isEmpty()) {
				sql = "select * from income where income_teamcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, teamcode);
			} else {
				sql = "select * from income where income_date >= ? and income_date <= ? and income_teamcode=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sdate);
				pstmt.setString(2, edate);
				pstmt.setString(3, teamcode);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				IncomeBean dto = new IncomeBean();
				dto.setCode(rs.getInt("income_code"));
				dto.setTeamcode(rs.getString("income_teamcode"));
				dto.setDate(rs.getString("income_date"));
				dto.setBriefs(rs.getString("income_briefs"));
				dto.setTicket(rs.getInt("income_ticket"));
				dto.setGoods(rs.getInt("income_goods"));
				dto.setFan(rs.getInt("income_fan"));
				dto.setBroad(rs.getInt("income_broad"));
				dto.setSpon(rs.getInt("income_spon"));
				dto.setAd(rs.getInt("income_ad"));
				dto.setRent(rs.getInt("income_rent"));
				dto.setLoan(rs.getInt("income_loan"));
				dto.setPysell(rs.getInt("income_pysell"));
				list.add(dto);
				
			}
		} catch (Exception e) {
			System.out.println("getIncomeAll err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { 
				}
			}
		return list;
	}
	
	   // 새로운 메서드 추가
    public boolean incomeInsert(IncomeBean ibean) {
        boolean b = false;
        try {
            conn = ds.getConnection();
            String sql = "INSERT INTO income (income_teamcode, income_date, income_briefs, income_ticket, income_goods, income_fan, income_broad, income_spon, income_ad, income_rent, income_loan, income_pysell) "
            		+ "VALUES (?, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ibean.getTeamcode());
            pstmt.setString(2, ibean.getBriefs());
            pstmt.setInt(3, ibean.getTicket());
            pstmt.setInt(4, ibean.getGoods());
            pstmt.setInt(5, ibean.getFan());
            pstmt.setInt(6, ibean.getBroad());
            pstmt.setInt(7, ibean.getSpon());
            pstmt.setInt(8, ibean.getAd());
            pstmt.setInt(9, ibean.getRent());
            pstmt.setInt(10, ibean.getLoan());
            pstmt.setInt(11, ibean.getPysell());
            if (pstmt.executeUpdate() > 0) {
                b = true;
            }
        } catch (Exception e) {
            System.out.println("incomeInsert err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return b;
    }
    
    public boolean updateIncome(IncomeBean ibean) {
        boolean result = false;
        try {
            conn = ds.getConnection();
            String sql = "UPDATE income SET income_teamcode = ?, income_briefs = ?, income_ticket = ?, income_goods = ?, income_fan = ?, income_broad = ?, income_spon = ?, income_ad = ?, income_rent = ?, income_loan = ?, income_pysell = ? WHERE income_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, ibean.getTeamcode());
            pstmt.setString(2, ibean.getBriefs());
            pstmt.setInt(3, ibean.getTicket());
            pstmt.setInt(4, ibean.getGoods());
            pstmt.setInt(5, ibean.getFan());
            pstmt.setInt(6, ibean.getBroad());
            pstmt.setInt(7, ibean.getSpon());
            pstmt.setInt(8, ibean.getAd());
            pstmt.setInt(9, ibean.getRent());
            pstmt.setInt(10, ibean.getLoan());
            pstmt.setInt(11, ibean.getPysell());
            pstmt.setInt(12, ibean.getCode());
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        } catch (Exception e) {
            System.out.println("updateIncome err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return result;
    }

    public boolean deleteIncome(int code) {
        boolean result = false;
        try {
            conn = ds.getConnection();
            String sql = "DELETE FROM income WHERE income_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                result = true;
            }
        } catch (Exception e) {
            System.out.println("deleteIncome err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return result;
    }
    
    public IncomeBean getIncomeById(int code, String teamcode) {
        IncomeBean dto = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM income WHERE income_code = ? and income_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new IncomeBean();
                dto.setCode(rs.getInt("income_code"));
                dto.setTeamcode(rs.getString("income_teamcode"));
                dto.setBriefs(rs.getString("income_briefs"));
                dto.setTicket(rs.getInt("income_ticket"));
                dto.setGoods(rs.getInt("income_goods"));
                dto.setFan(rs.getInt("income_fan"));
                dto.setBroad(rs.getInt("income_broad"));
                dto.setSpon(rs.getInt("income_spon"));
                dto.setAd(rs.getInt("income_ad"));
                dto.setRent(rs.getInt("income_rent"));
                dto.setLoan(rs.getInt("income_loan"));
                dto.setPysell(rs.getInt("income_pysell"));
            }
        } catch (Exception e) {
            System.out.println("getIncomeById err : " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return dto;
    }
    
    public ArrayList<IncomeBean> getIncomeByOption(String option, String teamcode) {
        ArrayList<IncomeBean> list = new ArrayList<IncomeBean>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM income WHERE ";
            switch (option) {
                case "티켓":
                    sql += "income_ticket > 0 and income_teamcode=?";
                    break;
                case "굿즈":
                    sql += "income_goods > 0 and income_teamcode=?";
                    break;
                case "팬":
                    sql += "income_fan > 0 and income_teamcode=?";
                    break;
                case "방송권":
                    sql += "income_broad > 0 and income_teamcode=?";
                    break;
                case "스폰서":
                    sql += "income_spon > 0 and income_teamcode=?";
                    break;
                case "광고":
                    sql += "income_ad > 0 and income_teamcode=?";
                    break;
                case "대여료":
                    sql += "income_rent > 0 and income_teamcode=?";
                    break;
                case "임대":
                    sql += "income_loan > 0 and income_teamcode=?";
                    break;
                case "선수판매":
                    sql += "income_pysell > 0 and income_teamcode=?";
                    break;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                IncomeBean dto = new IncomeBean();
                dto.setCode(rs.getInt("income_code"));
                dto.setTeamcode(rs.getString("income_teamcode"));
                dto.setBriefs(rs.getString("income_briefs"));
                dto.setDate(rs.getString("income_date"));
                dto.setTicket(rs.getInt("income_ticket"));
                dto.setGoods(rs.getInt("income_goods"));
                dto.setFan(rs.getInt("income_fan"));
                dto.setBroad(rs.getInt("income_broad"));
                dto.setSpon(rs.getInt("income_spon"));
                dto.setAd(rs.getInt("income_ad"));
                dto.setRent(rs.getInt("income_rent"));
                dto.setLoan(rs.getInt("income_loan"));
                dto.setPysell(rs.getInt("income_pysell"));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("getIncomeByOption err : " + e);
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
