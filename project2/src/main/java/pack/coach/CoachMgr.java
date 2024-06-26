package pack.coach;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CoachMgr {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private DataSource ds;

    public CoachMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
        } catch (Exception e) {
            System.out.println("DB 연결 실패: " + e);
        }
    }

    public ArrayList<CoachBean> getCoachesByCategory(String category, String teamcode) {
        ArrayList<CoachBean> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM coach WHERE coach_pos=? and coach_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CoachBean bean = new CoachBean();
                bean.setCode(rs.getInt("coach_code"));
                bean.setTeamcode(rs.getString("coach_teamcode"));
                bean.setName(rs.getString("coach_name"));
                bean.setPos(rs.getString("coach_pos"));
                bean.setLic(rs.getString("coach_lic"));
                bean.setIbdan(rs.getString("coach_ibdan"));
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

    public ArrayList<CoachBean> getAllCoaches(String teamcode) {
        ArrayList<CoachBean> list = new ArrayList<>();
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM coach WHERE coach_pos IN ('수석코치', '코치', 'GK코치', '피지컬코치', '비디오코치') and coach_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamcode);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                CoachBean bean = new CoachBean();
                bean.setCode(rs.getInt("coach_code"));
                bean.setTeamcode(rs.getString("coach_teamcode"));
                bean.setName(rs.getString("coach_name"));
                bean.setPos(rs.getString("coach_pos"));
                bean.setLic(rs.getString("coach_lic"));
                bean.setIbdan(rs.getString("coach_ibdan"));
                list.add(bean);
            }
        } catch (Exception e) {
            System.out.println("getAllCoaches() 에러: " + e);
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
    
    public boolean addCoach(CoachBean coach) {
        boolean isSuccess = false;
        try {
            conn = ds.getConnection();
            String sql = "INSERT INTO coach (coach_teamcode, coach_name, coach_pos, coach_lic, coach_ibdan) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, coach.getTeamcode());
            pstmt.setString(2, coach.getName());
            pstmt.setString(3, coach.getPos());
            pstmt.setString(4, coach.getLic());
            pstmt.setString(5, coach.getIbdan());

            if (pstmt.executeUpdate() > 0) {
                isSuccess = true;
            }
        } catch (Exception e) {
            System.out.println("addCoach err: " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
        return isSuccess;
    }

    public boolean isCoachNameDuplicate(String coachName, String teamcode) {
        boolean isDuplicate = false;
        try {
            conn = ds.getConnection();
            String checkSql = "SELECT COUNT(*) FROM coach WHERE coach_name = ? and coach_teamcode=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, coachName);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }
        } catch (Exception e) {
            System.out.println("isCoachNameDuplicate err: " + e);
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
    
    public CoachBean getByCoachCode(int code, String teamcode) {
        CoachBean coach = null;
        try {
            conn = ds.getConnection();
            String sql = "SELECT * FROM coach WHERE coach_code = ? and coach_teamcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            pstmt.setString(2, teamcode);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                coach = new CoachBean();
                coach.setCode(rs.getInt("coach_code"));
                coach.setTeamcode(rs.getString("coach_teamcode"));
                coach.setName(rs.getString("coach_name"));
                coach.setPos(rs.getString("coach_pos"));
                coach.setLic(rs.getString("coach_lic"));
                coach.setIbdan(rs.getString("coach_ibdan"));
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
        return coach;
    }
    
    public boolean isCodeDuplicate(int code, String teamcode) {
        boolean isDuplicate = false;
        try {
            conn = ds.getConnection();
            String checkSql = "SELECT COUNT(*) FROM coach WHERE coach_code = ? and coach_teamcode=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setInt(1, code);
            pstmt.setString(2, teamcode);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }
        } catch (Exception e) {
            System.out.println("isCodeDuplicate err: " + e);
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

    public boolean coachUpdate(CoachBean coach) {
        boolean updated = false;
        try {
            conn = ds.getConnection();
            String sql = "UPDATE coach SET coach_name = ?, coach_teamcode = ?, coach_pos = ?, coach_lic = ?, coach_ibdan = ? WHERE coach_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, coach.getName());
            pstmt.setString(2, coach.getTeamcode());
            pstmt.setString(3, coach.getPos());
            pstmt.setString(4, coach.getLic());
            pstmt.setString(5, coach.getIbdan());
            pstmt.setInt(6, coach.getCode());

            int rowCount = pstmt.executeUpdate();
            if (rowCount > 0) {
                updated = true;
            }
        } catch (Exception e) {
            System.out.println("update err: " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
        return updated;
    }

    public boolean isNameDuplicate(String name, String teamcode) {
        boolean isDuplicate = false;
        try {
            conn = ds.getConnection();
            String checkSql = "SELECT COUNT(*) FROM coach WHERE coach_name = ? and coach_teamcode=?";
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

    public void coachDelete(int code) {
        try {
            conn = ds.getConnection();
            String sql = "DELETE FROM coach WHERE coach_code = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, code);
            pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("deleteCoach err: " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
            }
        }
    }
}