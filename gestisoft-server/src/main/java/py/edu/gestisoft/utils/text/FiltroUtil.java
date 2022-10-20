package py.edu.gestisoft.utils.text;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class FiltroUtil {
	static String offSet = "-04:00";

	public static String geraFiltroRelatorio(String dtInicio, String dtFim, String nome) {
		String result = "DESDE EL " + formatDateTimeCurto(dtInicio, offSet) + " HASTA "
				+ formatDateTimeCurto(dtFim, offSet) + " " + nome;
		return result.toUpperCase();
	}

	public static String toBetween(String dtInicial, String dtFinal) {

		String condition;
		condition = " BETWEEN DATE(\"" + dtInicial + "\") AND DATE(\"" + dtFinal + "\")";
		return condition;
	}

	public static String addCliente(String clientes) {
		String condition = "";
		if (!clientes.isEmpty() && clientes != null) {
			condition = " AND ag.ID_CLIENTE IN (" + clientes + ")";
		}
		return condition;
	}

	public static String addProfissionais(String profissionais) {
		String condition = "";
		if (!profissionais.isEmpty() && profissionais != null) {
			condition = " AND ai.ID_PROFISSIONAL IN (" + profissionais + ")";
		}
		return condition;
	}

	public static String verCanceladas(Boolean verCanceladas) {
		String condition = "";
		if (verCanceladas == false) {
			condition = " AND ai.BO_CANCELADO IS FALSE";
		}
		return condition;
	}

	private static String formatDateTimeCurto(String date, String offSet) {
		String pattern = "dd-MM-yyyy";
		SimpleDateFormat fromUser = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sd = new SimpleDateFormat(pattern);
		String result = "";
		try {
			result = sd.format(fromUser.parse(date));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}

	public static String stringToChar(String value) {
		return "\"" + value + "\"";
	}

}
