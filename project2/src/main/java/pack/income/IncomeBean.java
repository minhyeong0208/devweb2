package pack.income;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class IncomeBean {
	private String teamcode, briefs, date;
	private int code, ticket, goods, fan, broad, spon, ad, rent, loan, pysell;
}
