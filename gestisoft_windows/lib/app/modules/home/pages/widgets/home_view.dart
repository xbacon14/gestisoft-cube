import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
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
  final DataShared dataShared = Modular.get();
  final mainScrollController = ScrollController();
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
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 48),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          width: size.width * .3,
                          height: 300,
                          child: Acrylic(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "Descripción",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 96,
                                        child: Text(
                                          "Stock actual",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(.1),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    height: 2,
                                    width: size.width * .24,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        productoController.productos.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                productoController
                                                        .productos[index]
                                                        .nombre ??
                                                    '',
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .body,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                "${NumberFormater.format(productoController.productos[index].cantidad!, productoController.productos[index].resolvePrecisionUnidadMedida())} ${productoController.productos[index].resolveUnidadMedida()}",
                                                textAlign: TextAlign.end,
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .body,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
        )),
        Expanded(child: Container()),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Text(
              dataShared.version,
              style: FluentTheme.of(context).typography.subtitle,
            )
          ],
        )
      ],
    );
  }
}
