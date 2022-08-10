import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';

class SinConexionPage extends StatefulWidget {
  const SinConexionPage({Key? key}) : super(key: key);

  @override
  State<SinConexionPage> createState() => _SinConexionPageState();
}

class _SinConexionPageState extends State<SinConexionPage> {
  final HomeController homeController = Modular.get();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 800,
        maxHeight: 800,
      ),
      child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FluentIcons.unavailable_offline,
              size: 48,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "No se pudo contactar con el servidor",
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            const SizedBox(
              height: 24,
            ),
            FilledButton(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FluentIcons.refresh,
                        color: Colors.white,
                      ),
                      Text("Intentar nuevamente"),
                    ],
                  ),
                ),
                onPressed: () => homeController.verificarConexion()),
          ],
        ),
      ),
    );
  }
}
