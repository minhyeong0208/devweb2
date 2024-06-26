package pack.stat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StatDto {
	private int code, bn, match, goal, as, yellow, red;
	private String season;  
}
