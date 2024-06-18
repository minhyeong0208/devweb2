package pack.expend;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExpendDto {
	private String teamcode, date, briefs;
	private int code, pybuy, trans, eat, maintain, cosalary, hcsalary, stsalary, training, mkting;
}