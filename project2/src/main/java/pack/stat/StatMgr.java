package pack.stat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StatMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	// paging 처리
	private int totalRecord;  		// tot : 전체 레코드 수
	private int pagePerRow = 10;      // 페이지 당 출력 행 수 
	private int pageCount;         // 전체 페이지 수 
	int filterRow = 0;             // 필터링된 데이터의 전체 개수를 저장할 변수
	
	public StatMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}
	
	public boolean statInsert(StatBean sbean) {
		boolean bool = false;
		
		try {
			String sql = "insert into stat(stat_bn,stat_season,stat_match,stat_goal,stat_as,stat_yellow,stat_red) values(?,?,?,?,?,?,?)";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sbean.getBn());
			pstmt.setString(2, sbean.getSeason());
			pstmt.setInt(3, sbean.getMatch());
			pstmt.setInt(4, sbean.getGoal());
			pstmt.setInt(5, sbean.getAs());
			pstmt.setInt(6, sbean.getYellow());
			pstmt.setInt(7, sbean.getRed());
			
			if(pstmt.executeUpdate() > 0) bool = true;
			
		} catch (Exception e) {
			System.out.println("statInsert err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return bool;
	}
	
	public StatDto getStat(String code) {
		StatDto dto = null;
		
		try {
			String sql = "select * from stat where stat_code=?";
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new StatDto();
				
				dto.setCode(rs.getInt("stat_code"));
				dto.setBn(rs.getInt("stat_bn"));
				dto.setSeason(rs.getString("stat_season"));
				dto.setMatch(rs.getInt("stat_match"));
				dto.setGoal(rs.getInt("stat_goal"));
				dto.setAs(rs.getInt("stat_as"));
				dto.setYellow(rs.getInt("stat_yellow"));
				dto.setRed(rs.getInt("stat_red"));
			}
		} catch (Exception e) {
			System.out.println("getStat err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return dto;
	}
	
	public boolean statUpdate(StatBean sbean) {
		boolean bool = false;
		
		try {
			String sql = "update stat set stat_bn=?,stat_season=?,stat_match=?,stat_goal=?,stat_as=?,stat_yellow=?,stat_red=? where stat_code=?";
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sbean.getBn());
			pstmt.setString(2, sbean.getSeason());
			pstmt.setInt(3, sbean.getMatch());
			pstmt.setInt(4, sbean.getGoal());
			pstmt.setInt(5, sbean.getAs());
			pstmt.setInt(6, sbean.getYellow());
			pstmt.setInt(7, sbean.getRed());
			pstmt.setInt(8, sbean.getCode());
			
			if (pstmt.executeUpdate() > 0) bool = true;
			
		} catch (Exception e) {
			System.out.println("statUpdate err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return bool;
	}
	
	public boolean statDelete(int code) {
		boolean bool = false;
		
		try {
			String sql = "delete from stat where stat_code=?";
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			if(pstmt.executeUpdate() > 0) bool = true;
			
		} catch (Exception e) {
			System.out.println("statDelete err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return bool;
	}
	
	public ArrayList<StatBean> getStatistic(String teamcode) {
		ArrayList<StatBean> list = new ArrayList<StatBean>();

		try {
			String sql = "select stat_code,stat_bn,player_name,substr(stat_season,1,4) as stat_season,stat_match,stat_goal,stat_as,stat_yellow,stat_red from stat inner join player on player_bn=stat_bn where player_teamcode=? order by stat_season desc";

			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, teamcode);
			rs = pstmt.executeQuery();
			
			// 페이지 당 10행 출력
			int i = 0;
			while(rs.next()  && i < pagePerRow) {
				StatBean dto = new StatBean();
				dto.setCode(rs.getInt("stat_code"));
				dto.setBn(rs.getInt("stat_bn"));
				dto.setName(rs.getString("player_name"));
				dto.setSeason(rs.getString("stat_season"));
				dto.setMatch(rs.getInt("stat_match"));
				dto.setGoal(rs.getInt("stat_goal"));
				dto.setAs(rs.getInt("stat_as"));
				dto.setYellow(rs.getInt("stat_yellow"));
				dto.setRed(rs.getInt("stat_red"));
				list.add(dto);
				i++;
			}
			
		} catch (Exception e) {
			System.out.println("getStatistic() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return list;
	}
	
	// 선택 기간 데이터 출력
	public ArrayList<StatBean> getStatistic(int page, String column, String sort, String start, String end, String teamcode) {
		ArrayList<StatBean> list = new ArrayList<StatBean>();
		
		try {
			String sql = "";
			
			if(sort.equals("desc")) {
				// 일정 기간 내의 데이터 내림차순
				sql = "select stat_code,stat_bn,player_name,substr(stat_season,1,4) as stat_season,stat_match,stat_goal,stat_as,stat_yellow,stat_red from stat inner join player on player_bn=stat_bn where stat_season>=? and stat_season<=? and player_teamcode=? order by " + column +  " desc";
			} else {
				// 일정 기간 내의 데이터 오름차순
				sql = "select stat_code,stat_bn,player_name,substr(stat_season,1,4) as stat_season,stat_match,stat_goal,stat_as,stat_yellow,stat_red from stat inner join player on player_bn=stat_bn where stat_season>=? and stat_season<=? and player_teamcode=?";
			}
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			pstmt.setString(3, teamcode);
			rs = pstmt.executeQuery();
			
			// 페이징 처리
			for(int i = 0; i < (page - 1) * pagePerRow; i++) {
				rs.next(); // 레코드 포인터 이동    0, 9, 19 ...
			}
			
			// 페이지 당 10행 출력
			int i = 0;
			while(rs.next()  && i < pagePerRow) {
				StatBean dto = new StatBean();
				dto.setCode(rs.getInt("stat_code"));
				dto.setBn(rs.getInt("stat_bn"));
				dto.setName(rs.getString("player_name"));
				dto.setSeason(rs.getString("stat_season"));
				dto.setMatch(rs.getInt("stat_match"));
				dto.setGoal(rs.getInt("stat_goal"));
				dto.setAs(rs.getInt("stat_as"));
				dto.setYellow(rs.getInt("stat_yellow"));
				dto.setRed(rs.getInt("stat_red"));
				list.add(dto);
				i++;
			}
			
		} catch (Exception e) {
			System.out.println("getStatistic() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		return list;
	}
	
	// 레코드 수 구하기
	public void totalList(String start, String end, String teamcode) {  
		String sql = "select count(*) as total from stat inner join player on player_bn=stat_bn where stat_season>=? and stat_season<=? and player_teamcode=?";
			
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, start);
	        pstmt.setString(2, end);
	        pstmt.setString(3, teamcode);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);  // 전체 레코드 수
			//System.out.println(totalRecord);
		} catch (Exception e) {
			System.out.println("totalList() err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
	}
	
	// 페이지 수 반환
	public int getPageCount() {
		pageCount = totalRecord / pagePerRow;
		if(totalRecord % pagePerRow > 0) pageCount++;
		//System.out.println("pageCount : " + pageCount);
		//System.out.println("totalRecord : " + totalRecord);
		return pageCount;
	}
	
	
	// 일정 기간 동안의 팀 전체 데이터(득점, 도움, 경고, 퇴장)
	public StatBean getTotalStat(String start, String end, String teamcode) {
		StatBean bean = null;
		
		try {
			String sql = "select sum(stat_goal), sum(stat_as), sum(stat_yellow), sum(stat_red) from stat inner join player on player_bn=stat_bn where stat_season>=? and stat_season<=? and player_teamcode=?";
			
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			pstmt.setString(3, teamcode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new StatBean();
				
				bean.setTotalGoal(rs.getInt(1));
				bean.setTotalAs(rs.getInt(2));
				bean.setTotalYellow(rs.getInt(3));
				bean.setTotalRed(rs.getInt(4));
			}
		} catch (Exception e) {
			System.out.println("getTotalStat err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return bean;
	}
}
