import 'package:fluent_ui/fluent_ui.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    Key? key,
    required this.onSubmited,
    required this.onClear,
    required this.placeholder,
  }) : super(key: key);

  final Function(String value) onSubmited;
  final Function onClear;
  final String placeholder;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController searchFieldController = TextEditingController();

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: searchFieldController,
      onSubmitted: (value) => widget.onSubmited(value),
      placeholder: widget.placeholder,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onEditingComplete: () {},
      suffix: TextButton(
        style:
            ButtonStyle(backgroundColor: ButtonState.all(Colors.transparent)),
        child: searchFieldController.text.isNotEmpty
            ? const Icon(FluentIcons.clear)
            : const Icon(FluentIcons.search),
        onPressed: () {
          setState(() {
            if (searchFieldController.text.isNotEmpty) {
              searchFieldController.clear();
              widget.onClear();
            } else {
              widget.onSubmited(searchFieldController.text);
            }
          });
        },
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }
}
