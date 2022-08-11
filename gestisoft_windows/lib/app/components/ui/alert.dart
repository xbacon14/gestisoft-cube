import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class Alert {
  String title = "";
  IconData? icon;
  Color? color;
  Alert.show(
      {required BuildContext context,
      required String text,
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

    showBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        return SizedBox(
          height: 64,
          child: InfoBar(
            title: Text(
              title,
            ),
            content: Text(text),
            severity: type == 0
                ? InfoBarSeverity.success
                : type == 1
                    ? InfoBarSeverity.warning
                    : InfoBarSeverity.error,
          ),
        );
      },
    );
  }
}
