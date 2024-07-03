package pack.stat;

import lombok.Data;

@Data
public class StatBean {
	private int code, bn, match, goal, as, yellow, red;
	private String season, name;  
	
	// 통계를 위한 멤버 필드 선언
	private int totalGoal, totalAs, totalYellow, totalRed;
	
}
