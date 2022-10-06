import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';
import 'package:mobx/mobx.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  final viewKey = GlobalKey();

  final DataShared dataShared = Modular.get();
  final HomeController homeController = Modular.get();

  @override
  void initState() {
    windowManager.addListener(this);
    homeController.verificarConexion();
    reaction<bool>((r) => homeController.online, ((p0) {
      if (p0 == false) {
        Modular.to.pushNamed('/sin_conexion');
      } else {
        Modular.to.pushNamed('/home');
      }
    }));
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
    final navBarTextStyle = FluentTheme.of(context).typography.bodyLarge;
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
                        style: FluentTheme.of(context).typography.title,
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
                          const Icon(FluentIcons.calendar),
                          const SizedBox(width: 12),
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
        selected: homeController.index,
        onChanged: (i) {
          setState(() {
            homeController.index = i;
          });

          switch (homeController.index) {
            case 0:
              Modular.to.pushNamed("/home");
              break;
            case 1:
              Modular.to.pushNamed("/cliente/");
              break;
            case 2:
              Modular.to.pushNamed("/vendedor/");
              break;
            case 3:
              Modular.to.pushNamed("/producto/");
              break;
            case 4:
              Modular.to.pushNamed("/venta/reporte");
              break;
            case 5:
              Modular.to.pushNamed("/venta/");
              break;
            case 6:
              Modular.to.pushNamed("/configuracion/");
              break;
            // case 6:
            //   Modular.to.pushNamed("/about/");
            //   break;
          }
        },
        items: [
          // 0
          PaneItem(
            title: Text("Inicio", style: navBarTextStyle),
            icon: const Icon(FluentIcons.home),
          ),
          // 1
          PaneItem(
            title: Text("Cliente", style: navBarTextStyle),
            icon: const Icon(FluentIcons.people),
          ),
          // 2
          PaneItem(
            title: Text("Vendedor", style: navBarTextStyle),
            icon: const Icon(FluentIcons.diamond_user),
          ),
          // 3
          PaneItem(
            title: Text("Productos", style: navBarTextStyle),
            icon: const Icon(FluentIcons.product_list),
          ),
          // 4
          PaneItem(
            title: Text("Reporte ventas", style: navBarTextStyle),
            icon: const Icon(FluentIcons.shop_server),
          ),
          // 5
          PaneItem(
            title: Text("Venta", style: navBarTextStyle),
            icon: const Icon(FluentIcons.shopping_cart),
          ),
          //6
          PaneItem(
            title: Text("Configuración", style: navBarTextStyle),
            icon: const Icon(FluentIcons.settings),
          ),
          // 6
          PaneItem(
            title: Text("Acerca de", style: navBarTextStyle),
            icon: const Icon(FluentIcons.info),
          ),
        ],
        displayMode: PaneDisplayMode.compact,
      ),
      content: const RouterOutlet(),
    );
  }
}
