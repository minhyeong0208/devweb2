package pack.staff;

import java.sql.Connection; // SQL 패키지 임포트
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context; // JNDI 패키지 임포트
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class StaffMgr {
    Connection conn; // 데이터베이스 연결 객체
    PreparedStatement pstmt; // SQL 문 실행 객체
    ResultSet rs; // SQL 쿼리 결과 저장 객체
    DataSource ds; // 데이터베이스 커넥션 풀 객체

    // 생성자: 데이터베이스 연결 설정
    public StaffMgr() {
        try {
            Context context = new InitialContext();
            ds = (DataSource) context.lookup("java:comp/env/jdbc_maria"); // JNDI를 사용하여 DataSource 객체 조회
        } catch (Exception e) {
            System.out.println("DB 연결 에러 " + e); // 예외 발생 시 에러 메시지 출력
        }
    }

    // 모든 스태프 정보 불러오기
    public ArrayList<StaffBean> getStaffAll(String teamcode) {
        ArrayList<StaffBean> list = new ArrayList<StaffBean>(); // 스태프 정보를 저장할 리스트
        
        try {
            conn = ds.getConnection(); // 데이터베이스 연결
            String sql = "SELECT * FROM staff where staff_teamcode=? order by staff_role asc"; // SQL 쿼리
            pstmt = conn.prepareStatement(sql); // SQL 문 준비
            pstmt.setString(1, teamcode); // 팀 코드 설정
            rs = pstmt.executeQuery(); // 쿼리 실행
            while (rs.next()) {
                StaffBean staff = new StaffBean(); // 스태프 객체 생성
                staff.setCode(rs.getInt("staff_code")); // 스태프 코드 설정
                staff.setName(rs.getString("staff_name")); // 스태프 이름 설정
                staff.setTeamcode(rs.getString("staff_teamcode")); // 스태프 팀 코드 설정
                staff.setNation(rs.getString("staff_nation")); // 스태프 국적 설정
                staff.setRole(rs.getString("staff_role")); // 스태프 역할 설정
                staff.setIbdan(rs.getString("staff_ibdan")); // 스태프 입단일 설정
                list.add(staff); // 리스트에 추가
            }
        } catch (Exception e) {
            System.out.println("getStaffAll err: " + e.getMessage()); // 예외 발생 시 에러 메시지 출력
        } finally {
            try {
                if (rs != null) rs.close(); // ResultSet 객체 닫기
                if (pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if (conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) {
                // 예외 처리
            }
        }
        return list; // 리스트 반환
    }

    // 스태프 정보 추가하기
    public boolean staffInsert(StaffBean sbean) {
        boolean b = false; // 추가 성공 여부를 나타내는 변수 초기화
        try {
            conn = ds.getConnection(); // 데이터베이스 연결
            String Sql = "insert into staff(staff_code,staff_name,staff_teamcode,staff_nation,staff_role,staff_ibdan)" + " values(?,?,?,?,?,?)"; // SQL 쿼리
            pstmt = conn.prepareStatement(Sql); // SQL 문 준비
            pstmt.setInt(1, sbean.getCode()); // 스태프 코드 설정
            pstmt.setString(2, sbean.getName()); // 스태프 이름 설정
            pstmt.setString(3, sbean.getTeamcode()); // 스태프 팀 코드 설정
            pstmt.setString(4, sbean.getNation()); // 스태프 국적 설정
            pstmt.setString(5, sbean.getRole()); // 스태프 역할 설정
            pstmt.setString(6, sbean.getIbdan()); // 스태프 입단일 설정
            if(pstmt.executeUpdate() > 0) b = true; // 쿼리 실행 후 성공 여부 설정
            
        } catch (Exception e) {
            System.out.println("insertData err: " + e.getMessage()); // 예외 발생 시 에러 메시지 출력
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close(); // ResultSet 객체 닫기
                if (pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if (conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) {
                // 예외 처리
            }
        }
        return b; // 성공 여부 반환
    }

    // 스태프 정보 가져오기
    public StaffBean getStaff(String code, String teamcode) {
        StaffBean sBean = null; // 스태프 객체 초기화
        try {
            conn = ds.getConnection(); // 데이터베이스 연결
            String sql = "select * from staff where staff_code=? and staff_teamcode=?"; // SQL 쿼리
            pstmt = conn.prepareStatement(sql); // SQL 문 준비
            pstmt.setString(1, code); // 스태프 코드 설정
            pstmt.setString(2, teamcode); // 팀 코드 설정
            rs = pstmt.executeQuery(); // 쿼리 실행
            
            if(rs.next()) {
                sBean = new StaffBean(); // 스태프 객체 생성
                
                sBean.setCode(rs.getInt("staff_code")); // 스태프 코드 설정
                sBean.setName(rs.getString("staff_name")); // 스태프 이름 설정
                sBean.setTeamcode(rs.getString("staff_teamcode")); // 스태프 팀 코드 설정
                sBean.setNation(rs.getString("staff_nation")); // 스태프 국적 설정
                sBean.setRole(rs.getString("staff_role")); // 스태프 역할 설정
                sBean.setIbdan(rs.getString("staff_ibdan")); // 스태프 입단일 설정
            }
        } catch (Exception e) {
            System.out.println("staffUpdate err : " + e); // 예외 발생 시 에러 메시지 출력
        } finally {
            try {
                if(rs != null) rs.close(); // ResultSet 객체 닫기
                if(pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if(conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) {
                // 예외 처리
            }
        }
        return sBean; // 스태프 객체 반환
    }

    // 스태프 정보 수정하기
    public boolean staffUpdate(StaffBean sBean) {
        boolean bool = false; // 수정 성공 여부를 나타내는 변수 초기화
        
        try {
            String sql = "update staff set staff_name=?,staff_teamcode=?,staff_nation=?,staff_role=?,staff_ibdan=? where staff_code=?"; // SQL 쿼리
            
            conn = ds.getConnection(); // 데이터베이스 연결
            pstmt = conn.prepareStatement(sql); // SQL 문 준비
            pstmt.setString(1, sBean.getName()); // 스태프 이름 설정
            pstmt.setString(2, sBean.getTeamcode()); // 스태프 팀 코드 설정
            pstmt.setString(3, sBean.getNation()); // 스태프 국적 설정
            pstmt.setString(4, sBean.getRole()); // 스태프 역할 설정
            pstmt.setString(5, sBean.getIbdan()); // 스태프 입단일 설정
            pstmt.setInt(6, sBean.getCode()); // 스태프 코드 설정
            
            if (pstmt.executeUpdate() > 0) bool = true; // 쿼리 실행 후 성공 여부 설정
            
        } catch (Exception e) {
            System.out.println("staffUpdate err : " + e); // 예외 발생 시 에러 메시지 출력
        } finally {
            try {
                if(rs != null) rs.close(); // ResultSet 객체 닫기
                if(pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if(conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) { }
        }
        
        return bool; // 성공 여부 반환
    }

    // 스태프 정보 삭제하기
    public boolean staffDelete(int code) {
        boolean bool = false; // 삭제 성공 여부를 나타내는 변수 초기화
        
        try {
            String sql = "delete from staff where staff_code=?"; // SQL 쿼리
            
            conn = ds.getConnection(); // 데이터베이스 연결
            pstmt = conn.prepareStatement(sql); // SQL 문 준비
            pstmt.setInt(1, code); // 스태프 코드 설정
            
            if(pstmt.executeUpdate() > 0) bool = true; // 쿼리 실행 후 성공 여부 설정
            
        } catch (Exception e) {
            System.out.println("staffDelete err : " + e); // 예외 발생 시 에러 메시지 출력
        } finally {
            try {
                if(rs != null) rs.close(); // ResultSet 객체 닫기
                if(pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if(conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) { }
        }
        
        return bool; // 성공 여부 반환
    }

    // 카테고리별 스태프 정보 가져오기
    public ArrayList<StaffBean> getStaffByCategory(String category, String teamcode) {
        ArrayList<StaffBean> list = new ArrayList<>(); // 스태프 정보를 저장할 리스트
        try {
            conn = ds.getConnection(); // 데이터베이스 연결
            String sql = "SELECT * FROM staff WHERE staff_role=? and staff_teamcode=?"; // SQL 쿼리
            pstmt = conn.prepareStatement(sql); // SQL 문 준비
            pstmt.setString(1, category); // 카테고리 설정
            pstmt.setString(2, teamcode); // 팀 코드 설정
            rs = pstmt.executeQuery(); // 쿼리 실행

            while (rs.next()) {
                StaffBean bean = new StaffBean(); // 스태프 객체 생성
                bean.setCode(rs.getInt("staff_code")); // 스태프 코드 설정
                bean.setName(rs.getString("staff_name")); // 스태프 이름 설정
                bean.setTeamcode(rs.getString("staff_teamcode")); // 스태프 팀 코드 설정
                bean.setNation(rs.getString("staff_nation")); // 스태프 국적 설정
                bean.setRole(rs.getString("staff_role")); // 스태프 역할 설정
                bean.setIbdan(rs.getString("staff_ibdan")); // 스태프 입단일 설정
                list.add(bean); // 리스트에 추가
            }
        } catch (Exception e) {
            System.out.println("getCoachesByCategory() 에러: " + e); // 예외 발생 시 에러 메시지 출력
        } finally {
            try {
                if (rs != null) rs.close(); // ResultSet 객체 닫기
                if (pstmt != null) pstmt.close(); // PreparedStatement 객체 닫기
                if (conn != null) conn.close(); // Connection 객체 닫기
            } catch (Exception e2) {
                // 예외 처리
            }
        }
        return list; // 리스트 반환
    }
}
