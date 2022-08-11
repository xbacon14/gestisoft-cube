class StringUtils {
  static bool emailValidator(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  static String formatCiRuc(String documento) {
    documento = documento.split('').reversed.join();
    String result = "";
    final value = documento.replaceAllMapped(
        RegExp(r".{3}"), (match) => "${match.group(0)} ");
    documento = value.split(' ').reversed.join(".");
    if (documento.length > 9 ||
        documento.length == 8 ||
        documento.length == 4) {
      documento = documento.substring(1);
    }
    return documento;
  }
}
