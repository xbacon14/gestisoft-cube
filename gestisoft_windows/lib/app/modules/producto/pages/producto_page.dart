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
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/widgets/filtro_producto_dialog.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/widgets/producto_formulario.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/widgets/producto_table.dart';
import './producto_controller.dart';

class ProductoPage extends StatefulWidget {
  const ProductoPage({
    Key? key,
  });

  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final ProductoController productoController = Modular.get();
  final HomeController homeController = Modular.get();
  final DataShared dataShared = Modular.get();
  int selected = 0;
  final values = [
    "Codigo",
    "Descripcion",
  ];

  bool isSelected(int value) {
    if (value != selected) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    productoController.findAllProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return productoController.processando
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
                                            // productoController.findByNombreODocumento(value);
                                            setState(() {});
                                          },
                                          placeholder: "Consulte por nombre",
                                          onClear: () => debugPrint("limpio")),
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
                                                    productoController.productos
                                                        .sort((a, b) => a.id!
                                                            .compareTo(b.id!));
                                                    setState(
                                                      () {
                                                        selected = 0;
                                                      },
                                                    );
                                                  } else if (newColor
                                                          ?.compareTo(
                                                              "Descripcion") ==
                                                      0) {
                                                    productoController.productos
                                                        .sort((a, b) =>
                                                            a.nombre!.compareTo(
                                                                b.nombre!));
                                                    setState(
                                                      () {
                                                        selected = 1;
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
                                                      return const FiltroProductoDialog();
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
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext ctx) {
                                                      return const ProductoFormulario();
                                                    });
                                              },
                                              child: Row(
                                                children: const [
                                                  Icon(FluentIcons.add),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text("Nuevo producto"),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              productoController.currentRecord =
                                                  Producto.nuevo();
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext ctx) {
                                                    return const ProductoFormulario();
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Observer(
                                  builder: ((context) {
                                    return productoController.processando
                                        ? const Center(child: Text("Cargando"))
                                        : productoController.listaVacia
                                            ? EmptyState(
                                                texto:
                                                    "No se retornado ningún producto, deseas registar uno?",
                                                icono: const Icon(
                                                  FluentIcons
                                                      .remove_from_shopping_list,
                                                  size: 48,
                                                ),
                                                onButtonPressed: () =>
                                                    showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const ProductoFormulario(),
                                                ),
                                                buttonTitle:
                                                    'Registrar producto',
                                              )
                                            : ProductoTable();
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
        ;
      },
    );
  }
}
