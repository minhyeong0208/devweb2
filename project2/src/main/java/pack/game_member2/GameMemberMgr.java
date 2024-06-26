package pack.game_member2;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

public class GameMemberMgr {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    // ConnPooling
    public GameMemberMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("GameMgr DB 연결 실패 : " + e);
        }
    }

    // 연도별 평균 수치 가져오기
    public HashMap<String, Double> getAvgByYear(int year, String teamcode){
        HashMap<String, Double> map = new HashMap<>();
        try {
            conn = ds.getConnection();
            // 유효슈팅률, 태클성공률, 평균볼점유율
            String sql = "select count(*) as whole_game, avg(game_sot) as sot_percent, "
                            + "avg(game_poss) as poss_percent, "
                            + "avg(game_tac) as tac_percent "
                            + "from game "
                            + "where (game_home = ? or game_away = ?) and year(game_date) = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            pstmt.setString(2, teamcode);
            pstmt.setInt(3, year);
            rs = pstmt.executeQuery();
            if(rs.next()){
                map.put("sot_percent", rs.getDouble("sot_percent"));
                //map.put("pass_percent", rs.getDouble("pass_percent"));
                map.put("tac_percent", rs.getDouble("tac_percent"));
                map.put("poss_avg", rs.getDouble("poss_percent"));
            }
            
            // 승률
            int whole_game = rs.getInt("whole_game"); // 전체 경기수

            //int win_game = 0; // 이긴 경기수
            int win_home = 0; // 홈에서 이긴 경기수

            sql = "select count(*) as win_game " +
                        "from game " +
                        "where year(game_date) = ? and game_home = ? " +
                        "and game_homesc > game_awaysc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, year);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if(rs.next()){
                win_home = rs.getInt("win_game");
            }

            int win_away = 0; // 원정에서 이긴 경기수
            sql = "select count(*) as win_game " +
                    "from game " +
                    "where year(game_date) = ? and game_away = ? " +
                    "and game_homesc < game_awaysc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, year);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if(rs.next()){
                win_away = rs.getInt("win_game");
            }

            //
            double win_percent = (((win_home + win_away) / (double) whole_game) * 100);
            map.put("win_percent", win_percent);


        } catch (Exception e) {
            System.out.println("getAvgByYear() err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return map;
    }
    
    // 구분별(홈, 어웨이) 평균 수치 구하기
    public HashMap<String, Double> getAvgByGubun(int year, String teamcode){
        HashMap<String, Double> map = new HashMap<>();
        try {
            conn = ds.getConnection();
            
            // 홈팀일 때 유효슈팅률, 태클성공률, 평균볼점유율
            String sql = "select count(*) as whole_game, avg(game_sot) as sot_percent, "
		            		+ "avg(game_poss) as poss_percent, "
		            		+ "avg(game_tac) as tac_percent "
		            		+ "from game "
		            		+ "where game_home = ? and year(game_date) = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            pstmt.setInt(2, year);
            rs = pstmt.executeQuery();
            if(rs.next()){
                map.put("sot_percent", rs.getDouble("sot_percent"));
                //map.put("pass_percent", rs.getDouble("pass_percent"));
                map.put("tac_percent", rs.getDouble("tac_percent"));
                map.put("poss_avg", rs.getDouble("poss_percent"));
            }
            
            // 승률
            int whole_game = rs.getInt("whole_game"); // 전체 경기수

            int win_game = 0; // 이긴 경기수
            sql = "select count(*) as win_game "
            		+ "from game "
            		+ "where year(game_date) = ? and game_home = ? "
            		+ "and game_homesc > game_awaysc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, year);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if(rs.next()){
                win_game = rs.getInt("win_game");
            }
            //
            double win_percent = ((win_game / (double) whole_game) * 100);
            map.put("win_percent", win_percent);
            
        } catch (Exception e) {
            System.out.println("getAvgByGubun() err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return map;
    }
    
    // 승무패 수치 구하기
    public HashMap<String, Integer> getResultRatio(int year, String teamcode){
        HashMap<String, Integer> map = new HashMap<>();
        
        try {
            conn = ds.getConnection();
            // 홈경기 승무패
            String sql = "select result, count(*) as result_cnt " +
                            "from " +
                                "(select case when game_home = ? then case when (game_homesc > game_awaysc) then 'win' " +
                                                                                "when (game_homesc = game_awaysc) then 'draw' " +
                                                                                "else 'lose' " +
                                                                                "end " +
                                                "else case when (game_homesc < game_awaysc) then 'win' " +
                                                            "when (game_homesc = game_awaysc) then 'draw' " +
                                                            "else 'lose' " +
                                                            "end " +
                                                "end as result " +
                                "from game " +
                                "where (game_home = ? or game_away=?) " +
                                "and year(game_date) = ?) T1 " +
                        "group by T1.result " +
                        "order by result";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            pstmt.setString(2, teamcode);
            pstmt.setString(3, teamcode);
            pstmt.setInt(4, year);
            rs = pstmt.executeQuery();
            while(rs.next()){
                map.put(rs.getString("result"), rs.getInt("result_cnt"));
            }

        } catch (Exception e) {
            System.out.println("getAvgByYear() err : " + e);
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) { }
        }
        return map;
    }

}
