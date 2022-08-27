class StringUtils {
  static bool emailValidator(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static String formatCiRuc(String documento) {
    return documento;
  }

  static String eliminarObjetoNombreResolve({required String nombre}) {
    List<String> lista = nombre.split(" ");
    return lista.first;
  }
}
