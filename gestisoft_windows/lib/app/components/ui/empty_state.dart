import 'package:fluent_ui/fluent_ui.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.texto,
    required this.icono,
    required this.onButtonPressed,
    required this.buttonTitle,
  }) : super(key: key);

  final String texto;
  final Widget icono;
  final String buttonTitle;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            icono,
            const SizedBox(
              height: 16,
            ),
            Text(texto),
            const SizedBox(
              height: 16,
            ),
            FilledButton(
              onPressed: onButtonPressed(),
              style: FluentTheme.of(context).buttonTheme.defaultButtonStyle,
              child: Text(
                buttonTitle,
                style: FluentTheme.of(context).typography.body!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
