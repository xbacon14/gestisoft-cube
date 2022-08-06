import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/ui/custom_scaffold.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/widget/cliente_item_render.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  bool filtroExpanded = false;
  String color = "Azul";
  List<String> colorList = [
    "azul",
    "verde",
    "vermelho",
    "amarelo",
    "laranja",
    "roxo",
  ];
  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              "Lista de clientes",
              style: theme.typography.subtitle,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 600),
            child: Acrylic(
              elevation: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        width: 330,
                        child: TextBox(
                          placeholder: "Consulte por nombre o ci",
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          suffix: const Icon(FluentIcons.search),
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: Combobox<String>(
                          icon: const Icon(FluentIcons.sort),
                          placeholder: const Text("Filtrar por"),
                          value: color,
                          isExpanded: filtroExpanded,
                          onTap: () {
                            setState(() {
                              filtroExpanded = !filtroExpanded;
                            });
                          },
                          items: colorList.map((e) {
                            Key k = ValueKey(e);
                            return ComboboxItem<String>(key: k, child: Text(e));
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: CommandBar(
                          primaryItems: [
                            CommandBarButton(
                              icon: const Icon(FluentIcons.add),
                              label: const Text("Nuevo cliente"),
                              onPressed: () {},
                            ),
                            CommandBarButton(
                              icon: const Icon(FluentIcons.pdf),
                              label: const Text("Exportar"),
                              onPressed: () {},
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
                  // ListView.builder(
                  //   itemCount: 10,
                  //   itemBuilder: (_, index) =>
                  //       const ClienteItemRender(nombre: "CLIENTE"),
                  // ),
                ],
              ),
            ),
          )
          // const ClienteDataTable(),
        ],
      ),
    );
  }
}
