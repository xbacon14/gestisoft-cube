import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AutoCompleteTextInput extends StatefulWidget {
  final String? text;
  final String label;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final Widget? icon;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool isPassword;
  final bool autoFocus;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final Function(String)? onSubmited;
  final dynamic order;
  final TextStyle? style;
  final TextCapitalization? textCapitalization;

  const AutoCompleteTextInput(
      {Key? key,
      this.text,
      this.icon,
      this.autoFocus = false,
      this.isPassword = false,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.minLines,
      this.maxLines,
      this.enabled = true,
      this.contentPadding,
      this.maxLength,
      this.inputFormatters,
      this.errorText,
      required this.label,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      this.onSubmited,
      this.validator,
      this.order,
      this.textCapitalization,
      this.style})
      : super(key: key);

  @override
  _AutoCompleteTextInputState createState() => _AutoCompleteTextInputState();
}

class _AutoCompleteTextInputState extends State<AutoCompleteTextInput> {
  final controller = TextEditingController();
  bool focado = false;

  late FocusOrder order;

  @override
  void initState() {
    focado = widget.autoFocus;
    if (widget.order is num) {
      order = NumericFocusOrder((widget.order as num).toDouble());
    } else {
      order = LexicalFocusOrder(widget.order.toString());
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AutoCompleteTextInput oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var value = widget.text;
      if (value == null || value.isEmpty || value == 'null') {
        controller.text = "";
        value = "";
      }
      controller.text = value;
      controller.value = controller.value.copyWith(
        text: value,
        selection:
            TextSelection(baseOffset: value.length, extentOffset: value.length),
        composing: TextRange.empty,
      );
    });
    super.didUpdateWidget(oldWidget);
  }

  void bugFixAcentos(String value) {
    if (kIsWeb) {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    } else {
      if (Platform.isWindows) {
        int pos = controller.selection.start;
        String newValue = value
            // A
            .replaceAll('´´a', 'á')
            .replaceAll('``a', 'à')
            .replaceAll('^^a', 'â')
            .replaceAll('~~a', 'ã')
            .replaceAll('´´A', 'Á')
            .replaceAll('``A', 'À')
            .replaceAll('^^A', 'Â')
            .replaceAll('~~A', 'Ã')
            // E
            .replaceAll('´´e', 'é')
            .replaceAll('``e', 'è')
            .replaceAll('^^e', 'ê')
            .replaceAll('´´E', 'É')
            .replaceAll('``E', 'È')
            .replaceAll('^^E', 'Ê')
            // I
            .replaceAll('´´i', 'í')
            .replaceAll('``i', 'ì')
            .replaceAll('^^i', 'î')
            .replaceAll('´´I', 'Í')
            .replaceAll('``I', 'Ì')
            .replaceAll('^^I', 'î')
            // O
            .replaceAll('´´o', 'ó')
            .replaceAll('``o', 'ò')
            .replaceAll('^^o', 'ô')
            .replaceAll('~~o', 'õ')
            .replaceAll('´´O', 'Ó')
            .replaceAll('``O', 'Ò')
            .replaceAll('^^O', 'Ô')
            .replaceAll('~~O', 'Õ')
            // U
            .replaceAll('´´u', 'ú')
            .replaceAll('``u', 'ù')
            .replaceAll('^^u', 'û')
            .replaceAll('´´U', 'Ú')
            .replaceAll('``U', 'Ù')
            .replaceAll('^^U', 'Û');

        /// Makes the cursor stay in the correct place
        pos -= (value.length - newValue.length);
        if (pos > newValue.length) {
          pos = newValue.length;
        }
        controller.selection =
            TextSelection.fromPosition(TextPosition(offset: pos));
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      } else {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            focado = hasFocus;
          });
        },
        child: FocusTraversalOrder(
          order: order,
          child: TextFormBox(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              bugFixAcentos(value);
            },
            style: widget.style ?? const TextStyle(color: Colors.white),
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            maxLength: widget.maxLength,
            minLines: widget.minLines, //Normal textInputField will be displayed
            maxLines: widget.maxLines, //
            enabled: widget.enabled, //
            initialValue: widget.text,
            validator: widget.validator,
            obscureText: widget.isPassword,
            controller: widget.controller,
            autofocus: widget.autoFocus,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            textAlign: TextAlign.start,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onSubmited,

            cursorColor: Colors.blue,
            // decoration: BoxDecoration(
            // border: InputBorder.none,
            // errorBorder: InputBorder.none,
            // enabledBorder: InputBorder.none,
            // focusedBorder: InputBorder.none,
            // disabledBorder: InputBorder.none,
            // focusedErrorBorder: InputBorder.none,
            // errorText: (widget.errorText),
            // contentPadding: widget.contentPadding ??
            //     const EdgeInsets.only(
            //         left: 10.0, right: 10, bottom: 0, top: 10),
            // hintText: widget.hintText,
            // filled: true,
            // labelText: widget.label,
            // suffixIcon: widget.icon,
            // labelStyle: Get.textTheme.headline5!.copyWith(
            //   fontSize: 10,
            //   color: Colors.white,
            //   letterSpacing: .5,
            // ),
            // ),
          ),
        ),
      ),
    );
  }
}
