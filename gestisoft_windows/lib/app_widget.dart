import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/core/navigator/globals.dart';
import 'package:gestisoft_windows/app/components/ui/ui_config.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    Modular.setNavigatorKey(navigatorKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      locale: const Locale('es', 'PY'),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        accentColor: Colors.red,
        iconTheme: const IconThemeData(size: 24),
      ),
      color: Colors.red,
    );
  }
}
