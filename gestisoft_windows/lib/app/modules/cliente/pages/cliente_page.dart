import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/search_text_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/components/ui/empty_state.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/widget/cliente_formulario.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/widget/cliente_table.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final ClienteController clienteController = Modular.get();
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
    clienteController.findAllClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                            clienteController.findByNombreODocumento(value);
                            setState(() {});
                          },
                          onClear: () =>
                              clienteController.findByNombreODocumento(''),
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
                                      clienteController.clientes.sort(
                                          (a, b) => a.id!.compareTo(b.id!));
                                      setState(
                                        () {
                                          selected = 0;
                                        },
                                      );
                                    } else if (newColor?.compareTo("Nombre") ==
                                        0) {
                                      clienteController.clientes.sort((a, b) =>
                                          a.nombre!.compareTo(b.nombre!));
                                      setState(
                                        () {
                                          selected = 1;
                                        },
                                      );
                                    } else if (newColor
                                            ?.compareTo("Documento") ==
                                        0) {
                                      clienteController.clientes.sort((a, b) =>
                                          a.ciRuc!.compareTo(b.ciRuc!));
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
                                        return const ClienteFormulario();
                                      });
                                },
                                child: Row(
                                  children: const [
                                    Icon(FluentIcons.add),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Nuevo cliente"),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                clienteController.currentRecord =
                                    Cliente().nuevo();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return const ClienteFormulario();
                                    });
                              },
                            ),
                          ],
                        ),
                      ),

                      // DropDownButton(
                      //   title: Text(
                      //     "Ordenar por",
                      //     style: theme.typography.body,
                      //   ),
                      //   items: [
                      //     MenuFlyoutItem(
                      //         text: const Text("Nombre"), onPressed: () {})
                      //   ],
                      // )
                    ],
                  ),
                  Observer(
                    builder: ((context) {
                      return clienteController.processando
                          ? const Center(child: Text("Cargando"))
                          : clienteController.listaVacia
                              ? EmptyState(
                                  texto:
                                      "No se retornado ningún cliente, deseas registar uno?",
                                  icono: const Icon(
                                    FluentIcons.remove_from_shopping_list,
                                    size: 48,
                                  ),
                                  onButtonPressed: () =>
                                      debugPrint("registrar cliente"),
                                  buttonTitle: 'Registrar cliente',
                                )
                              : ClienteTable();
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
                style: FluentTheme.of(context).typography.subtitle,
              )
            ],
          )
        ],
      ),
    );
  }
}
