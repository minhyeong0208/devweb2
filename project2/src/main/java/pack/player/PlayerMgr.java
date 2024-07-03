package pack.player;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PlayerMgr {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public PlayerMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("DB 연결 실패 : " + e);
        }
    }

    public ArrayList<PlayerBean> getPlayersByPosition(String position, String teamcode) {
        ArrayList<PlayerBean> list = new ArrayList<PlayerBean>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM player WHERE player_pos = ? and player_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, position);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PlayerBean player = new PlayerBean();
                player.setBn(rs.getInt("player_bn"));
                player.setName(rs.getString("player_name"));
                player.setTeamcode(rs.getString("player_teamcode"));
                player.setBirth(rs.getString("player_birth"));
                player.setPos(rs.getString("player_pos"));
                player.setNation(rs.getString("player_nation"));
                player.setPot(rs.getString("player_pot"));
                player.setCts(rs.getString("player_cts"));
                player.setCte(rs.getString("player_cte"));
                player.setDeb(rs.getString("player_deb"));
                list.add(player);
            }
        } catch (Exception e) {
            System.out.println("getPlayersByPosition err: " + e);
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

    public ArrayList<PlayerBean> getAllPlayers(String teamcode) {
        ArrayList<PlayerBean> list = new ArrayList<PlayerBean>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM player WHERE player_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PlayerBean player = new PlayerBean();
                player.setBn(rs.getInt("player_bn"));
                player.setName(rs.getString("player_name"));
                player.setTeamcode(rs.getString("player_teamcode"));
                player.setBirth(rs.getString("player_birth"));
                player.setPos(rs.getString("player_pos"));
                player.setNation(rs.getString("player_nation"));
                player.setPot(rs.getString("player_pot"));
                player.setCts(rs.getString("player_cts"));
                player.setCte(rs.getString("player_cte"));
                player.setDeb(rs.getString("player_deb"));
                list.add(player);
            }
        } catch (Exception e) {
            System.out.println("getAllPlayers err: " + e);
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

    // 선수 등번호로 선수 정보 가져오기
    public PlayerBean getPlayerByBn(int bn, String teamcode) {
        PlayerBean player = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM player WHERE player_bn = ? and player_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bn);
            pstmt.setString(2, teamcode);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                player = new PlayerBean();
                player.setBn(rs.getInt("player_bn"));
                player.setName(rs.getString("player_name"));
                player.setBirth(rs.getString("player_birth"));
                player.setNation(rs.getString("player_nation"));
                player.setTeamcode(rs.getString("player_teamcode"));
                player.setPos(rs.getString("player_pos"));
                player.setPot(rs.getString("player_pot"));
                player.setCts(rs.getString("player_cts"));
                player.setCte(rs.getString("player_cte"));
                player.setDeb(rs.getString("player_deb"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return player;
    }

    // 선수 정보 업데이트
    public boolean updatePlayer(PlayerBean player) {
        boolean updated = false;
        try {
            conn = ds.getConnection();
            String sql = "UPDATE player SET player_name = ?, player_birth = ?, player_nation = ?, player_teamcode = ?, player_pos = ?, player_pot = ?, player_cts = ?, player_cte = ?, player_deb = ? WHERE player_bn = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, player.getName());
            pstmt.setString(2, player.getBirth());
            pstmt.setString(3, player.getNation());
            pstmt.setString(4, player.getTeamcode());
            pstmt.setString(5, player.getPos());
            pstmt.setString(6, player.getPot());
            pstmt.setString(7, player.getCts());
            pstmt.setString(8, player.getCte());
            pstmt.setString(9, player.getDeb());
            pstmt.setInt(10, player.getBn());

            int rowCount = pstmt.executeUpdate();
            if (rowCount > 0) {
                updated = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return updated;
    }

    public void deletePlayer(int bn) {
        try {
        	conn = ds.getConnection();
        	String sql = "DELETE FROM stat where stat_bn = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bn);
            pstmt.executeUpdate();
            
            sql = "DELETE FROM player WHERE player_bn = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bn);
            pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("deletePlayer err: " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
    }

    public boolean isBnDuplicate(int bn, String teamcode) {
        boolean isDuplicate = false;
        try {
            conn = ds.getConnection();
            String checkSql = "SELECT COUNT(*) FROM player WHERE player_bn = ? and player_teamcode=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, bn);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }
        } catch (Exception e) {
            System.out.println("isBnDuplicate err: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
        return isDuplicate;
    }

    public boolean isNameDuplicate(String name, String teamcode) {
        boolean isDuplicate = false;
        try {
            conn = ds.getConnection();
            String checkSql = "SELECT COUNT(*) FROM player WHERE player_name = ? and player_teamcode=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, name);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }
        } catch (Exception e) {
            System.out.println("isNameDuplicate err: " + e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
        return isDuplicate;
    }

    public boolean addPlayer(PlayerBean player) throws Exception {
        boolean b = false;
        try {
            conn = ds.getConnection();
            String sql = "INSERT INTO player (player_bn, player_name, player_birth, player_nation, player_pos, player_teamcode, player_pot, player_cts, player_cte, player_deb) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, player.getBn());
            pstmt.setString(2, player.getName());
            pstmt.setString(3, player.getBirth());
            pstmt.setString(4, player.getNation());
            pstmt.setString(5, player.getPos());
            pstmt.setString(6, player.getTeamcode());
            pstmt.setString(7, player.getPot());
            pstmt.setString(8, player.getCts());
            pstmt.setString(9, player.getCte());
            pstmt.setString(10, player.getDeb());

            if (pstmt.executeUpdate() > 0) {
                b = true;
            }
        } catch (Exception e) {
            System.out.println("addPlayer err: " + e);
            throw e; // 예외를 다시 던져 JSP에서 처리할 수 있게 함
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
        return b;
    }
}
