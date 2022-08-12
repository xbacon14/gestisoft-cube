import 'package:fluent_ui/fluent_ui.dart';

class Alert {
  String title = "";
  IconData? icon;
  Color? color;
  Alert.show(
      {required BuildContext context,
      required String message,
      required int type}) {
    if (type == 0) {
      title = "Éxito";
      icon = FluentIcons.accept;
      color = Colors.green;
    } else if (type == 1) {
      title = "Aviso";
      icon = FluentIcons.warning;
      color = Colors.orange;
    } else {
      title = "Error";
      icon = FluentIcons.error_badge;
      color = Colors.red;
    }

    showSnackbar(
      context,
      SizedBox(
        height: 64,
        child: InfoBar(
          title: Text(
            title,
          ),
          content: Text(message),
          severity: type == 0
              ? InfoBarSeverity.success
              : type == 1
                  ? InfoBarSeverity.warning
                  : InfoBarSeverity.error,
        ),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
