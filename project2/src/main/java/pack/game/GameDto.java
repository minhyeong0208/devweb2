package pack.game;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GameDto {
	private int code, homesc, awaysc;
	private double poss, sot, tac;
	private String home, away, date, stadium;
}
