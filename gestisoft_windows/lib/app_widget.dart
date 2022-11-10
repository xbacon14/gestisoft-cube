import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/core/navigator/globals.dart';
import 'package:gestisoft_windows/app/components/ui/ui_config.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      theme: UiConfig.themeData,
      color: Colors.red,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        minWidth: 600,
        defaultName: TABLET,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.autoScale(500,
              name: TABLET, scaleFactor: 0.7),
          const ResponsiveBreakpoint.autoScale(1000,
              name: DESKTOP, scaleFactor: .6),
        ],
      ),
    );
  }
}
