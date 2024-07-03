package pack.member;


import lombok.Data;

@Data
public class MemberDto {
	private String name, birth, email, id, passwd, teamcode;
	private String teamname;

	
}
