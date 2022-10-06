import 'package:intl/intl.dart';

String formatNumber(double? number, int idMoeda) {
  number ??= 0.0;
  String vl = '';
  if (idMoeda == 1 || idMoeda == 4) {
    final numberFormat = NumberFormat("#,###", "es_PY");
    vl = numberFormat.format(number);
  } else {
    final numberFormat = NumberFormat("#,##0.00", "pt_BR");
    vl = numberFormat.format(number);
  }
  return vl;
}

String formatNumberTxtController(double? digits, int idMoeda) {
  if (digits == null) return '';
  // var allowFraction = false;
  late NumberFormat formatter;
  if (idMoeda == 1) {
    formatter = NumberFormat("#,###", "es_PY");
  }
  if (idMoeda == 2) {
    formatter = NumberFormat("#,###.##", "pt_BR");
    // allowFraction = true;
  }

  var result = (formatter).format(digits);
  return result;
}

String newFormatNumber(double number, int idMoeda) {
  var locale = '';
  var symbol = '';
  var precision = 0;
  if (idMoeda == 1) {
    locale = 'es_PY';
    symbol = 'G\$';
    precision = 0;
  } else {
    locale = 'br_PT';
    symbol = 'R\$';
    precision = 1;
  }

  final format = NumberFormat.currency(
    locale: locale,
    decimalDigits: precision,
    symbol: symbol,
  );

  String newString = format.format(number);
  return newString;
}

int formatMoedaPrecision(int idMoedaBase, int idMoeda) {
  int precision = 0;

  ///GUARANI///
  if (idMoedaBase == 1) {
    if (idMoeda == 1) {
      precision = 0;
    }
    if (idMoeda == 2) {
      precision = 0;
    }
    if (idMoeda == 3) {
      precision = 0;
    }
    if (idMoeda == 4) {
      precision = 0;
    }
  }

  ///REAL///
  if (idMoedaBase == 2) {
    if (idMoeda == 1) {
      precision = 0;
    }
    if (idMoeda == 2) {
      precision = 3;
    }
    if (idMoeda == 3) {
      precision = 3;
    }
    if (idMoeda == 4) {
      precision = 0;
    }
  }

  return precision;
}

String completeWith4Cero(int number) {
  final numberFormat = NumberFormat("0000");
  var formated = '';

  formated = numberFormat.format(number);

  return formated;
}

String completeWith11Cero(int number) {
  final numberFormat = NumberFormat("00000000000");
  var formated = '';

  formated = numberFormat.format(number);

  return formated;
}

String nrFaturaFormat(String nrFilial, String pontoExpedicao, int nrFatura) {
  final nrFaturaFormat = NumberFormat("000000000");
  var formated = '';

  formated = '$nrFilial-$pontoExpedicao-${nrFaturaFormat.format(nrFatura)}';

  return formated;
}
