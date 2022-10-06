import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_utils/string_utils.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class VentaTable extends StatelessWidget {
  VentaTable({Key? key}) : super(key: key);
  final VentaController ventaController = Modular.get();
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
                flex: 2,
                child: Text("Nombre"),
              ),
              Expanded(
                child: Text("CI/RUC"),
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
              SizedBox(
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: ventaController.dataProvider.length,
            itemBuilder: ((context, index) {
              Venta venta = ventaController.dataProvider[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Card(
                  elevation: 0,
                  backgroundColor: Colors.grey.withOpacity(.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CODIGO
                      SizedBox(
                        width: 48,
                        child: Text(
                          venta.id.toString(),
                          style: bodyTextStyle,
                        ),
                      ),
                      // NOMBRE
                      Expanded(
                        flex: 2,
                        child: Text(
                          venta.cliente?.nombre ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      // CI/RUC
                      Expanded(
                        child: Text(
                          StringUtils.formatCiRuc(venta.cliente?.ciRuc ?? ''),
                          style: bodyTextStyle,
                        ),
                      ),
                      // DIRECCION
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 100,
                            child: Text(
                              venta.direccion ?? '',
                              style: bodyTextStyle,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Expanded(
                        child: Text(
                          cliente.celular ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () {
                                clienteController.currentRecord = cliente;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return const ClienteFormulario(
                                        editar: true,
                                      );
                                    });
                              },
                              child: const Text("Editar"),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: ButtonState.all(Colors.red),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return EliminaClienteDialog(
                                        cliente:
                                            clienteController.clientes[index],
                                      );
                                    });
                              },
                              child: const Text("Eliminar"),
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
