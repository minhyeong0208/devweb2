package pack.stat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StatDto {
	private int bn, match, goal, as, yellow, red;
	private String code, season;  
}
