import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'pattern_formatter/number_formater.dart';
import 'pattern_formatter/numeric_formatter.dart';

class NumberInputCustom extends StatefulWidget {
  final String? labelText;
  final double? numberValue;
  final Color? fontColor;
  final bool? enabled;
  final ValueChanged<double>? onChanged;
  final ValueChanged<String>? onSubmited;
  final String? errorText;
  final FocusNode? focusNode;
  final Color? borderSideColor;
  final double? fontSize;
  final bool autoFocus;
  final int precision;
  final int idMoedaFormat;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const NumberInputCustom({
    Key? key,
    this.labelText,
    this.fontColor,
    this.enabled,
    this.onSubmited,
    this.onChanged,
    this.errorText,
    this.numberValue,
    this.focusNode,
    this.borderSideColor,
    this.autoFocus = false,
    this.fontSize,
    this.precision = 0,
    this.idMoedaFormat = 1,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  NumberInputCustomState createState() => NumberInputCustomState();
}

class NumberInputCustomState extends State<NumberInputCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(NumberInputCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? fN;
    if (widget.controller == null) {
      if (widget.numberValue != null) {
        fN = formatNumber(
          widget.numberValue!,
          _setMoedaWithMoedaBase(),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText!),
        const SizedBox(
          height: 4,
        ),
        TextFormBox(
          initialValue: fN,
          controller: widget.controller,
          enabled: widget.enabled ?? true,
          style: FluentTheme.of(context).typography.body,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 1,
            ),
          ),
          onFieldSubmitted: widget.onSubmited,
          onChanged: (value) {
            var v = value;
            v = v.replaceAll('.', '');
            v = v.replaceAll(',', '.');
            try {
              widget.onChanged!(double.parse(v));
            } catch (e) {
              // print(e);
            }
          },
          inputFormatters: [inputFormatter()],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          focusNode: widget.focusNode,
          validator: widget.validator,
        ),
      ],
    );
  }

  TextInputFormatter inputFormatter() {
    if (widget.precision == 0) {
      return ThousandsFormatter(
        formatter: NumberFormat("#,###", "es_PY"),
      );
    } else {
      return ThousandsFormatter(
        formatter: NumberFormat("#,###0.00", "pt_BR"),
        allowFraction: true,
      );
    }
  }

  int _setMoedaWithMoedaBase() {
    if (widget.precision == 0) {
      return 1;
    } else {
      return 2;
    }
  }
}
