import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/ui/custom_scaffold.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/widget/cliente_item_render.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
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
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
            child: Acrylic(
              elevation: 2,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, index) =>
                    const ClienteItemRender(nombre: "CLIENTE"),
              ),
            ),
          )
          // const ClienteDataTable(),
        ],
      ),
    );
  }
}
