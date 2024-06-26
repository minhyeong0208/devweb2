package pack.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class MemberMgr {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	// ConnPooling
	public MemberMgr() {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("MemberMgr DB 연결 실패 : " + e);
		}
	}
	
	// 아이디 중복 검사
	public boolean idCheck(String id) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "select member_id from member where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("idCheck error : " + e);
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
		
	// 회원 추가
	public boolean memberInsert(MemberDto memberDto) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "insert into member values (?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDto.getName());
			pstmt.setString(2, memberDto.getBirth());
			pstmt.setString(3, memberDto.getEmail());
			pstmt.setString(4, memberDto.getId());
			pstmt.setString(5, memberDto.getPasswd());
			pstmt.setString(6, memberDto.getTeamcode());
			if(pstmt.executeUpdate() > 0) b = true;
			
		} catch (Exception e) {
			System.out.println("memberInsert error : " + e);
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
	
	// 로그인 시 회원 여부 체크
	public boolean loginCheck(String team_code, String id, String passwd) {
		boolean b = false;
		
		try {
			conn = ds.getConnection();
			String sql = "select * from member where member_teamcode = ? and member_id = ?";
			//String sql = "select * from member where member_teamcode = ? and member_id = ? and member_passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, team_code);
			pstmt.setString(2, id);
			//pstmt.setString(3, passwd);
			//System.out.println(team_code + " " + id + " " + passwd);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				System.out.println("아이디 존재");
				sql = "select * from member where member_teamcode = ? and member_id = ? and member_passwd = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, team_code);
				pstmt.setString(2, id);
				pstmt.setString(3, passwd);
				rs = pstmt.executeQuery();
				if(rs.next()){
					b = true;
				} else{
					System.out.println("비번 오류");
				}

			} else {
				System.out.println("가입한거 맞니");
			}
		} catch (Exception e) {
		System.out.println("loginCheck error : " + e);
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
	
	// 수정할 회원 정보 가져오기
	public MemberDto getMember(String id) {
		MemberDto mDto = null;
		try {
			conn = ds.getConnection();
			//String sql = "select * from member where member_id = ?";
			String sql = "select member_id, member_name, member_passwd, member_birth, member_email, member_teamcode, team_name from member"
							+ " inner join team on member_teamcode = team_code where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			// 직접 클릭해서 넘어오는 건데 자료 반드시 있는 것 아니냐
			// 주소창에 요청값을 직접 넣어서 넘어올 수 있으니 자료가 있는지 없는지 체크해줘야
			if(rs.next()) {
				mDto = new MemberDto();
				mDto.setId(rs.getString("member_id"));
				mDto.setName(rs.getString("member_name"));
				mDto.setBirth(rs.getString("member_birth"));
				mDto.setEmail(rs.getString("member_email"));
				mDto.setPasswd(rs.getString("member_passwd"));
				mDto.setTeamcode(rs.getString("member_teamcode"));
				mDto.setTeamname(rs.getString("team_name"));
			}

		} catch (Exception e) {
			System.out.println("getMember error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return mDto;
	}
	
	public boolean memberUpdate(MemberDto mDto, String id) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "update member set member_name = ?, member_passwd = ?, member_email = ?, "
							+ "member_birth = ?, member_teamcode = ? where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mDto.getName());
			pstmt.setString(2, mDto.getPasswd());
			pstmt.setString(3, mDto.getEmail());
			pstmt.setString(4, mDto.getBirth());
			pstmt.setString(5, mDto.getTeamcode());
			pstmt.setString(6, id);
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}

		} catch (Exception e) {
			System.out.println("memberUpdate error : " + e);
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
	
	public boolean memberDelete(String id) {
		boolean b = false;
		try {
			conn = ds.getConnection();
			String sql = "delete from member where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			if(pstmt.executeUpdate() > 0) {
				b = true;
			}
			
		} catch (Exception e) {
			System.out.println("memberDelete error : " + e);
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
	
	// DB 비밀번호 -> 메일로 전송한 임시 비밀번호로 변경
	//
	public void updatePasswd(String id, String tempPassword) {
		try {
			conn = ds.getConnection();
			String sql = "update member set member_passwd = ? where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tempPassword);
			pstmt.setString(2, id);
			if(pstmt.executeUpdate() > 0) {
				System.out.println("임시 비밀번호 변경 완료");
			}
			
		} catch (Exception e) {
			System.out.println("updatePasswd error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
	}
	
	// 아이디 찾기
	public MemberDto FindMemberId(String teamcode, String name, String email) {
		MemberDto mDto = new MemberDto();
		try {
			conn = ds.getConnection();
			String sql = "select member_id from member where member_teamcode = ? "
							+ "and member_name = ? and member_email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, teamcode);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mDto.setId(rs.getString("member_id"));
			}
			
			
		} catch (Exception e) {
			System.out.println("FindMemberId error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return mDto;
	}

	// 비밀번호 찾기
	public MemberDto FindMemberPw(String teamcode, String name, String email, String id) {
		MemberDto mDto = new MemberDto();
		try {
			conn = ds.getConnection();
			String sql = "select member_passwd from member where member_teamcode = ? "
					+ "and member_name = ? and member_email = ? and member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, teamcode);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mDto.setPasswd(rs.getString("member_passwd"));
			}


		} catch (Exception e) {
			System.out.println("FindMemberPw error : " + e);
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {

			}
		}
		return mDto;
	}

}
