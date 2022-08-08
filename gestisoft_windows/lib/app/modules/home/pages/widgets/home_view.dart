import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';
import 'package:gestisoft_windows/app/modules/home/pages/widgets/sin_conexion_page.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductoController productoController = Modular.get();
  final HomeController homeController = Modular.get();
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
            child: Observer(
          builder: ((context) => productoController.processando
              ? const Center(
                  child: Text("CARGANDO"),
                )
              : !homeController.online
                  ? const SinConexionPage()
                  : Container(
                      margin: const EdgeInsets.only(top: 48),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      width: size.width * .25,
                      height: 300,
                      child: Acrylic(
                        elevation: 2,
                        blurAmount: 3,
                        shadowColor: FluentTheme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Productos en stock",
                                style: FluentTheme.of(context)
                                    .typography
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    productoController.dataProvider.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      productoController
                                              .dataProvider[index].nombre ??
                                          '',
                                      style: FluentTheme.of(context)
                                          .typography
                                          .body,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
        )),
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
