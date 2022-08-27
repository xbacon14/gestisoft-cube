import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static DateTime toDate(String date) {
    return DateTime.parse(date);
  }

  static String format(DateTime date) {
    final f = DateFormat('dd/MM/yyyy HH:mm');
    return f.format(date);
  }

  static String formatDateTime(String date) {
    final f = DateFormat('dd/MM/yyyy - HH:mm');
    DateTime dt = toDate(date);
    return f.format(dt);
  }

  static String formatDate(String date) {
    final f = DateFormat('dd/MM/yyyy');
    DateTime dt = toDate(date);
    return f.format(dt);
  }

  static String formatDateToDiaAniversario(String date) {
    DateTime dateTime = toDate(date);
    DateFormat f = DateFormat.MMMMd(Get.deviceLocale!.toLanguageTag());
    return f.format(dateTime);
  }

  static String formatDateMesAno(String date) {
    final f = DateFormat('dd/MM');
    DateTime dt = toDate(date);
    return f.format(dt);
  }

  static String javaFormat(DateTime date) {
    final f = DateFormat('yyyy-MM-ddTHH:mm');
    return f.format(date);
  }

  static String dataPicker(DateTime date) {
    final f = DateFormat('dd-MM-yyyy');
    return f.format(date);
  }

  static String sqlDateFormat(String date) {
    final f = DateFormat('yyyy-MM-dd');
    DateTime dt = toDate(date);
    return f.format(dt);
  }

  /// 29 DE SETEMBRO DE 2021
  static String formatExtenso(DateTime date) {
    DateFormat f = DateFormat.yMMMMd(Get.deviceLocale!.toLanguageTag());
    return f.format(date);
  }

  /// CONVERTE UTC PARA DATA LOCAL E FORMATA 29/09/2021
  static String utfToLocalDateFormat(String date) {
    if (date.isEmpty) return '';
    var dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    return format(dateTime.toLocal());
  }

  /// CONVERTE UTC PARA DATA LOCAL E FORMATA 29 DE SETEMBRO DE 2021
  static String utfToLocalDateFormatExtenso(String date) {
    if (date.isEmpty) return '';
    var dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    return formatExtenso(dateTime.toLocal());
  }

  static String formatDateTimeToString(String date) {
    if (date.isEmpty) return '';
    return DateFormat.yMd(Get.deviceLocale!.toLanguageTag())
        .add_jm()
        .format(toDate(date));
  }

  static String formatDateTimeToStringExtenso(String date) {
    if (date.isEmpty) return '';
    return DateFormat.yMMMMd(Get.deviceLocale!.toLanguageTag())
        .add_jm()
        .format(toDate(date));
  }

  static String formatDateTimeToDate(DateTime date) {
    return DateFormat.yMd(Get.deviceLocale!.toLanguageTag())
        // .add_jm()
        .format(date);
  }

  static String formatDateTimeToDateExtenso(DateTime date) {
    return DateFormat.yMMMMd(Get.deviceLocale!.toLanguageTag())
        .add_jm()
        .format(date);
  }

  static DateTime utfToLocalDate(String date) {
    if (date.isEmpty) return DateTime.now();
    var dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    return dateTime.toLocal();
  }

  static String toUTCDate(String date) {
    if (date.isEmpty) return '';
    return DateTime.parse(date).toUtc().toIso8601String();
    // DateTime dateFormated =
    //     DateFormat('dd/MM/yyyy HH:mm', Get.deviceLocale.toLanguageTag())
    //         .parse(date);
    // return dateFormated.toString();
  }

  static String utfToLocalDateTime(String date) {
    if (date.isEmpty) return '';
    var dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    return formatDateTimeToDate(dateTime.toLocal());
  }

  static String utfToLocalDateTimeExtenso(String date) {
    if (date.isEmpty) return '';
    var dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date, true);
    return formatDateTimeToDateExtenso(dateTime.toLocal());
  }

  String formatDateLetters(
    DateTime date,
  ) {
    final dateFormatter =
        DateFormat('EEEE, M/d/y', Get.deviceLocale.toString());
    return dateFormatter.format(date).toUpperCase();
  }

  String formatDateString(String date) {
    if (date.isEmpty) {
      return '';
    }
    final dateFormatter = DateFormat('dd/MM/yy', Get.deviceLocale.toString());
    return dateFormatter.format(DateTime.parse(date));
  }

  String formatHour(DateTime date) {
    final dateFormatter = DateFormat('H:mm', Get.deviceLocale.toString());
    return dateFormatter.format(date).toUpperCase();
  }

  String getTipoDia(DateTime date) {
    final dateFormatter = DateFormat('a', Get.deviceLocale.toString());
    var tp = dateFormatter.format(date).toUpperCase();
    if (tp.compareTo('AM') == 0) {
      tp = 'home.menu.bom.dia'.tr;
    } else {
      if (date.hour >= 19) {
        tp = 'home.menu.boa.noite'.tr;
      } else {
        tp = 'home.menu.boa.tarde'.tr;
      }
    }
    return tp;
  }

  String formatHourString(String date) {
    if (date.isEmpty) {
      return '';
    }
    final dateFormatter = DateFormat('H:mm a', Get.deviceLocale.toString());
    return dateFormatter.format(DateTime.parse(date));
  }

  String formatHourMillesima(String date) {
    if (date.isEmpty) {
      return '';
    }
    final dateFormatter = DateFormat('H:mm:ss a', Get.deviceLocale.toString());
    return dateFormatter.format(DateTime.parse(date));
  }

  String resolveMesAnteriorEmLetras() {
    String result = "";
    DateFormat mesLetras = DateFormat('MMMM', Get.deviceLocale.toString());
    int diaMes = DateTime.now().day;
    DateTime mesAnterior = DateTime.now().subtract(Duration(days: diaMes + 1));
    result = mesLetras.format(mesAnterior);

    return result;
  }

  DateTime resolveUltimoDiaMes({required int mesAtual}) {
    DateTime result = DateTime.now();
    if (mesAtual < 12) {
      mesAtual = mesAtual + 1;
      DateTime mesAnterior = DateTime(DateTime.now().year, mesAtual, 1);
      result = mesAnterior.subtract(const Duration(days: 1));
    } else {
      result = DateTime(DateTime.now().year, 12, 31);
    }

    return result;
  }
}
