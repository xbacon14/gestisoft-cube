package py.edu.gestisoft.utils.sql;

public class SQLUtils {

	public static String like(String value) {
		if (value == null || value.isEmpty()) {
			return "'%%'";
		}
		return "'%" + value.toUpperCase() + "%'";
	}

	public static String addNombreCliente(String nombre) {
		if (!nombre.isEmpty() && nombre != null) {
			return "c.NOMBRE " + like(nombre);
		}
		return "";
	}

	public static String addDocumentoCliente(String documento) {
		if (!documento.isEmpty() && documento != null) {
			return "c.CI_RUC " + like(documento);
		}
		return "";
	}

}
