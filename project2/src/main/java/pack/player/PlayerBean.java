package pack.player;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class PlayerBean {
	private String name, teamcode, birth, pos, nation, pot, cts, cte, deb;
	private int bn;
}
