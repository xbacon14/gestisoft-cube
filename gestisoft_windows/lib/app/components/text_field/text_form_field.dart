import 'package:fluent_ui/fluent_ui.dart';

class TextFormField extends StatefulWidget {
  const TextFormField({
    Key? key,
    required this.title,
    this.onSubmited,
    required this.placeHolder,
    this.suffix,
    this.enabled = true,
    this.validator,
    this.value,
    required this.onChanged,
    this.maxChar,
  }) : super(key: key);

  final String title;
  final String placeHolder;
  final Function(String value)? onSubmited;
  final Function(String? value)? validator;
  final Function(String? value) onChanged;
  final Widget? suffix;
  final bool? enabled;
  final String? value;
  final int? maxChar;

  @override
  State<TextFormField> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends State<TextFormField> {
  final TextEditingController textFieldController = TextEditingController();
  @override
  void initState() {
    if (widget.value != null) {
      textFieldController.text = widget.value!;
    }
    super.initState();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 4,
        ),
        TextFormBox(
          maxLength: widget.maxChar,
          controller: textFieldController,
          enabled: widget.enabled,
          onFieldSubmitted: (value) =>
              widget.onSubmited != null ? widget.onSubmited!(value) : null,
          placeholder: widget.placeHolder,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          onEditingComplete: () {},
          suffix: widget.suffix,
          onChanged: (value) {
            setState(() {});
            widget.onChanged(value);
          },
          validator: (value) =>
              widget.validator != null ? widget.validator!(value) : null,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.red,
              width: 1,
            ),
          ),
        ),
      ],
    );
  }
}
