package pack.game;

import lombok.Data;

@Data
public class GameBean {
	private int code, homesc, awaysc;
	private double poss, sot, tac;
	private String home, away, date, stadium;
}
