package pack.game;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import pack.stat.StatBean;

public class GameMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;

	// paging 처리
	private int totalRecord; // tot : 전체 레코드 수
	private int pagePerRow = 10; // 페이지 당 출력 행 수
	private int pageCount; // 전체 페이지 수
	int filterRow = 0; // 필터링된 데이터의 전체 개수를 저장할 변수

	public GameMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("DB 연결 실패 : " + e);
		}
	}

	public ArrayList<GameBean> getGame(int page, String start, String end) {
		ArrayList<GameBean> list = new ArrayList<GameBean>();
		
		try {
			String sql = "select * from mat where mat_date>=? and mat_date<=?";

			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			rs = pstmt.executeQuery();

			// 페이징 처리
			for (int i = 0; i < (page - 1) * pagePerRow; i++) {
				rs.next(); // 레코드 포인터 이동 0, 9, 19 ...
			}

			// 페이지 당 10행 출력
			int i = 0;
			while (rs.next() && i < pagePerRow) {
				GameBean dto = new GameBean();
				dto.setCode(rs.getInt("mat_code"));
				dto.setHome(rs.getString("mat_home"));
				dto.setAway(rs.getString("mat_away"));
				dto.setDate(rs.getString("mat_date"));
				dto.setHomesc(rs.getInt("mat_homesc"));
				dto.setAwaysc(rs.getInt("mat_awaysc"));
				dto.setStadium(rs.getString("mat_stadium"));
				dto.setPoss(rs.getDouble("mat_poss"));
				dto.setSot(rs.getDouble("mat_sot"));
				dto.setTac(rs.getDouble("mat_tac"));
				list.add(dto);
				i++;
			}

		} catch (Exception e) {
			System.out.println("getGame() err : " + e);
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

	// 레코드 수 구하기
	public void totalList(String start, String end) {
		String sql = "select count(*) as total from mat where mat_date>=? and mat_date<=?";

		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, start);
			pstmt.setString(2, end);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1); // 전체 레코드 수
			// System.out.println(totalRecord);
		} catch (Exception e) {
			System.out.println("totalList() err : " + e);
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
	}

	// 페이지 수 반환
	public int getPageCount() {
		pageCount = totalRecord / pagePerRow;
		if (totalRecord % pagePerRow > 0)
			pageCount++;
		return pageCount;
	}
	
	
	// 경기 데이터 추가
	public boolean gameInsert(GameBean gbean) {
		boolean bool = false;
		
		try {
			String sql = "insert into mat(mat_home,mat_away,mat_date,mat_homesc,mat_awaysc,mat_stadium,mat_poss,mat_sot,mat_tac) values(?,?,?,?,?,?,?,?,?)";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, gbean.getHome());
			pstmt.setString(2, gbean.getAway());
			pstmt.setString(3, gbean.getDate());
			pstmt.setInt(4, gbean.getHomesc());
			pstmt.setInt(5, gbean.getAwaysc());
			pstmt.setString(6, gbean.getStadium());
			pstmt.setDouble(7, gbean.getPoss());
			pstmt.setDouble(8, gbean.getSot());
			pstmt.setDouble(9, gbean.getTac());
			if(pstmt.executeUpdate() > 0) bool = true;
			
		} catch (Exception e) {
			System.out.println("gameInsert err : " + e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) { }
		}
		
		return bool;
	}
}
