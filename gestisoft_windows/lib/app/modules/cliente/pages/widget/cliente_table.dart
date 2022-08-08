import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';

class ClienteTable extends StatelessWidget {
  ClienteTable({
    Key? key,
  }) : super(key: key);

  final ClienteController clienteController = Modular.get();

  @override
  Widget build(BuildContext context) {
    final bodyTextStyle = FluentTheme.of(context).typography.body!.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(.8),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                width: 48,
                child: Text("Cod"),
              ),
              Expanded(
                flex: 3,
                child: Text("Nombre"),
              ),
              Expanded(
                flex: 3,
                child: Text("Dirección"),
              ),
              Expanded(
                flex: 2,
                child: Text("Celular"),
              ),
              Expanded(
                child: Text("Acciones"),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: clienteController.clientes.length,
            itemBuilder: ((context, index) {
              Cliente cliente = clienteController.clientes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Card(
                  elevation: 0,
                  backgroundColor: Colors.grey.withOpacity(.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 48,
                        child: Text(
                          cliente.id.toString(),
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          cliente.nombre ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 100,
                            child: Text(
                              cliente.direccion ?? '',
                              style: bodyTextStyle,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          cliente.celular ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            FilledButton(
                              onPressed: (() => debugPrint("editar cliente")),
                              child: const Text("Editar"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
