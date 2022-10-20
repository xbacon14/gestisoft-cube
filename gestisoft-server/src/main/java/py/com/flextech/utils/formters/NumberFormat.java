package py.com.flextech.utils.formters;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class NumberFormat {

	public static String formataNumber(Long idMoeda, BigDecimal valor) {
		if (valor == null)
			return "0";
		if (idMoeda == 1) {
			return new DecimalFormat("#,###,##0").format(valor);
		} else {
			return new DecimalFormat("#,###,##0.00").format(valor);
		}
	}

}
