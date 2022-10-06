import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/search_text_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/components/ui/empty_state.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/widgets/vendedor_formulario.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/widgets/vendedor_table.dart';
import './vendedor_controller.dart';

class VendedorPage extends StatefulWidget {
  const VendedorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VendedorPage> createState() => _VendedorPageState();
}

class _VendedorPageState extends State<VendedorPage> {
  final VendedorController vendedorController = Modular.get();
  final DataShared dataShared = Modular.get();
  int selected = 0;
  final values = [
    "Codigo",
    "Nombre",
    "Documento",
  ];

  bool isSelected(int value) {
    if (value != selected) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    vendedorController.findAllVendedores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 1200,
        maxHeight: 800,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Acrylic(
              tint: FluentTheme.of(context).acrylicBackgroundColor,
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
                            vendedorController.findByNombreODocumento(value);
                            setState(() {});
                          },
                          onClear: () =>
                              vendedorController.findByNombreODocumento(''),
                          placeholder: "Consulte por nombre o documento",
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
                                icon: const Icon(FluentIcons.sort),
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
                                    if (newColor?.compareTo("Codigo") == 0) {
                                      vendedorController.vendedores.sort(
                                          (a, b) => a.id!.compareTo(b.id!));
                                      setState(
                                        () {
                                          selected = 0;
                                        },
                                      );
                                    } else if (newColor?.compareTo("Nombre") ==
                                        0) {
                                      vendedorController.vendedores.sort(
                                          (a, b) =>
                                              a.nombre!.compareTo(b.nombre!));
                                      setState(
                                        () {
                                          selected = 1;
                                        },
                                      );
                                    } else if (newColor
                                            ?.compareTo("Documento") ==
                                        0) {
                                      vendedorController.vendedores.sort(
                                          (a, b) => a.ci!.compareTo(b.ci!));
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          primaryItems: [
                            CommandBarButton(
                              icon: const Icon(FluentIcons.pdf),
                              label: const Text("Exportar a pdf"),
                              onPressed: () {
                                Alert.show(
                                    message: "Info", type: 0, context: context);
                              },
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.excel_logo),
                              label: const Text("Exportar a excel"),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              label: FilledButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return const VendedorFormulario();
                                      });
                                },
                                child: Row(
                                  children: const [
                                    Icon(FluentIcons.add),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Nuevo vendedor"),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                vendedorController.currentRecord =
                                    Vendedor.nuevo();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return const VendedorFormulario();
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
                      return vendedorController.processando
                          ? const Center(child: Text("Cargando"))
                          : vendedorController.listaVacia
                              ? EmptyState(
                                  texto:
                                      "No se retornado ningún vendedor, deseas registar uno?",
                                  icono: const Icon(
                                    FluentIcons.remove_from_shopping_list,
                                    size: 48,
                                  ),
                                  onButtonPressed: () =>
                                      debugPrint("registrar vendedor"),
                                  buttonTitle: 'Registrar vendedor',
                                )
                              : VendedorTable();
                    }),
                  ),
                ],
              ),
            ),
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
        ),
      ),
    );
  }
}
