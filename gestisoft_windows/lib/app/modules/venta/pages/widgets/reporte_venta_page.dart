import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/search_text_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/components/ui/empty_state.dart';
import 'package:gestisoft_windows/app/components/ui/loading_render.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';
import 'package:gestisoft_windows/app/modules/home/pages/widgets/sin_conexion_page.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/filtros_dialog.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/venta_table.dart';

class ReporteVentaPage extends StatefulWidget {
  const ReporteVentaPage({Key? key}) : super(key: key);

  @override
  State<ReporteVentaPage> createState() => _ReporteVentaPageState();
}

class _ReporteVentaPageState extends State<ReporteVentaPage> {
  final VentaController ventaController = Modular.get();
  final HomeController homeController = Modular.get();
  final DataShared dataShared = Modular.get();

  int selected = 0;
  final values = [
    "Codigo",
    "Vendedor",
    "Cliente",
    "Chofer",
    "Monto venta",
  ];

  bool isSelected(int value) {
    if (value != selected) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    ventaController.findAllVentas(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ventaController.processando
            ? const LoadingRender()
            : !homeController.online
                ? const SinConexionPage()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1200,
                            maxHeight: 800,
                          ),
                          child: Acrylic(
                            elevation: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(16),
                                      width: 360,
                                      child: SearchTextField(
                                        onSubmited: (value) {
                                          ventaController
                                              .findVentasPorNombreCliente(
                                                  context, value);
                                          setState(() {});
                                        },
                                        onClear: () {
                                          // ventaController.findByNombreODocumento('');
                                        },
                                        placeholder:
                                            "Consulte por nombre de cliente",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Row(
                                        children: [
                                          const Text("Ordenar por:"),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Combobox<String>(
                                              icon:
                                                  const Icon(FluentIcons.sort),
                                              value: values[selected],
                                              items: values
                                                  .map(
                                                    (e) => ComboboxItem<String>(
                                                      value: e,
                                                      child: Text(e),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (newColor) => setState(
                                                () {
                                                  if (newColor?.compareTo(
                                                          "Codigo") ==
                                                      0) {
                                                    ventaController.dataProvider
                                                        .sort((a, b) => a.id!
                                                            .compareTo(b.id!));
                                                    setState(
                                                      () {
                                                        selected = 0;
                                                      },
                                                    );
                                                  } else if (newColor
                                                          ?.compareTo(
                                                              "Vendedor") ==
                                                      0) {
                                                    ventaController.dataProvider
                                                        .sort((a, b) => a
                                                            .vendedor!.nombre!
                                                            .compareTo(b
                                                                .vendedor!
                                                                .nombre!));
                                                    setState(
                                                      () {
                                                        selected = 1;
                                                      },
                                                    );
                                                  } else if (newColor
                                                          ?.compareTo(
                                                              "Cliente") ==
                                                      0) {
                                                    ventaController.dataProvider
                                                        .sort((a, b) => a
                                                            .cliente!.nombre!
                                                            .compareTo(b
                                                                .cliente!
                                                                .nombre!));
                                                    setState(
                                                      () {
                                                        selected = 1;
                                                      },
                                                    );
                                                  } else if (newColor
                                                          ?.compareTo(
                                                              "Chofer") ==
                                                      0) {
                                                    ventaController.dataProvider
                                                        .sort((a, b) =>
                                                            a.chofer!.compareTo(
                                                                b.chofer!));
                                                    setState(
                                                      () {
                                                        selected = 2;
                                                      },
                                                    );
                                                  } else if (newColor
                                                          ?.compareTo(
                                                              "Monto venta") ==
                                                      0) {
                                                    ventaController.dataProvider
                                                        .sort((a, b) => a.total!
                                                            .compareTo(
                                                                b.total!));
                                                    setState(
                                                      () {
                                                        selected = 2;
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: CommandBar(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        primaryItems: [
                                          CommandBarButton(
                                            label: FilledButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      return const FiltroVentaDialog();
                                                    });
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                      FluentIcons.filter_solid),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "Filtros",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              Alert.show(
                                                  message: "Info",
                                                  type: 0,
                                                  context: context);
                                            },
                                          ),
                                          CommandBarButton(
                                            label: FilledButton(
                                              onPressed: () {
                                                Modular.to.pushNamed("/venta");
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(FluentIcons.add),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    "Nueva venta",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              Modular.to.pushNamed("/venta");
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Observer(
                                  builder: ((context) {
                                    return ventaController.processando
                                        ? const Center(child: Text("Cargando"))
                                        : ventaController.listaVacia
                                            ? EmptyState(
                                                texto:
                                                    "No se retornado ninguna venta, deseas registar una?",
                                                icono: const Icon(
                                                  FluentIcons
                                                      .remove_from_shopping_list,
                                                  size: 48,
                                                ),
                                                onButtonPressed: () =>
                                                    debugPrint(
                                                        "registrar venta"),
                                                buttonTitle: 'Registrar venta',
                                              )
                                            : VentaTable();
                                  }),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              dataShared.version,
                              style:
                                  FluentTheme.of(context).typography.subtitle,
                            )
                          ],
                        )
                      ],
                    ),
                  );
      },
    );
  }
}
