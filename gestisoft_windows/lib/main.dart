import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.blue,
        iconTheme: const IconThemeData(size: 24),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.blue,
        iconTheme: const IconThemeData(size: 24),
      ),
      home: NavigationView(
        appBar: const NavigationAppBar(
          title: Text("Gestisoft  v1.0"),
        ),
        pane: NavigationPane(displayMode: PaneDisplayMode.auto, items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text("Inicio"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.folder),
            title: const Text("Registros"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.asterisk_solid),
            title: const Text("Operaciones"),
          ),
        ]),
      ),
    );
  }
}
