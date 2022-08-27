import 'package:desktop_window/desktop_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/application_config.dart';
import 'package:gestisoft_windows/app_module.dart';
import 'package:gestisoft_windows/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationStarterConfig().configureApp();
  // if (!kIsWeb) {
  //   await DesktopWindow.setFullScreen(true);
  // }
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
