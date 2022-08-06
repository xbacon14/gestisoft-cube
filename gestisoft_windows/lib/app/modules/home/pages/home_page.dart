import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/core/navigator/globals.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  final viewKey = GlobalKey();
  int index = 0;
  final DataShared dataShared = Modular.get();

  @override
  void initState() {
    windowManager.addListener(this);
    Modular.to.pushNamed('/home');
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
              title: const Text("Confirmar cierre"),
              content:
                  const Text("¿Está seguro que desea cerrar la aplicación?"),
              actions: [
                FilledButton(
                  child: const Text("Cerrar"),
                  onPressed: () {
                    Navigator.pop(context);
                    windowManager.destroy();
                  },
                ),
                FilledButton(
                  child: const Text("Volver"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        title: !kReleaseMode
            ? SizedBox(
                height: 120,
                width: size.width * .96,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Center(
                      child: Text(
                        dataShared.nombreEmpresa,
                        style: FluentTheme.of(context).typography.subtitle,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          const Icon(FluentIcons.people),
                          const SizedBox(width: 12),
                          Text(
                            dataShared.nombreUsuario,
                            style: FluentTheme.of(context)
                                .typography
                                .body!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            DateUtil().formatDateString(
                              DateTime.now().toIso8601String(),
                            ),
                            style: FluentTheme.of(context)
                                .typography
                                .body!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Text(
                Modular.to.path,
              ),
      ),
      pane: NavigationPane(
        selected: index,
        onChanged: (i) {
          setState(() {
            index = i;
          });

          switch (index) {
            case 0:
              Modular.to.pushNamed("/home");
              break;
            case 1:
              Modular.to.pushNamed("/cliente/");
              break;
            case 2:
              Modular.to.pushNamed("/vendedor");
              break;
            case 3:
              Modular.to.pushNamed("/venta");
              break;
            case 4:
              Modular.to.pushNamed("/producto");
              break;
            case 5:
              Modular.to.pushNamed("/configuracion");
              break;
            case 6:
              Modular.to.pushNamed("/about");
              break;
          }
        },
        items: [
          // 0
          PaneItem(
            title: const Text("Inicio"),
            icon: const Icon(FluentIcons.home),
          ),
          // 1
          PaneItem(
            title: const Text("Cliente"),
            icon: const Icon(FluentIcons.people),
          ),
          // 2
          PaneItem(
            title: const Text("Vendedor"),
            icon: const Icon(FluentIcons.sell),
          ),
          // 3
          PaneItem(
            title: const Text("Venta"),
            icon: const Icon(FluentIcons.sell),
          ),
          // 4
          PaneItem(
            title: const Text("Productos"),
            icon: const Icon(FluentIcons.store_logo16),
          ),
          // 5
          PaneItem(
            title: const Text("Configuración"),
            icon: const Icon(FluentIcons.settings),
          ),
          // 6
          PaneItem(
            title: const Text("Acerca de"),
            icon: const Icon(FluentIcons.info),
          ),
        ],
        displayMode: PaneDisplayMode.top,
      ),
      content: const RouterOutlet(),
    );
  }
}
