import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductoController productoController = Modular.get();
  @override
  void initState() {
    productoController.findAllProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: size.width * .2,
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Productos en stock"),
                Observer(
                  builder: (_) => productoController.processando
                      ? const Center(
                          child: Text("CARGANDO"),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: productoController.dataProvider.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(productoController
                                      .dataProvider[index].nombre ??
                                  ''),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Text(
              "GESTISOFT v0.1 GUILLERMO CABALLERO - ITALO GOLIN",
              style: FluentTheme.of(context).typography.subtitle,
            )
          ],
        )
      ],
    );
  }
}
