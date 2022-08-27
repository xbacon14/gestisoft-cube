import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_utils/string_utils.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/widgets/eliminar_vendedor_dialog.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/widgets/vendedor_formulario.dart';

class VendedorTable extends StatelessWidget {
  VendedorTable({Key? key}) : super(key: key);

  final VendedorController vendedorController = Modular.get();

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
                flex: 2,
                child: Text("CI"),
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
            itemCount: vendedorController.vendedores.length,
            itemBuilder: ((context, index) {
              Vendedor vendedor = vendedorController.vendedores[index];
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
                          vendedor.id.toString(),
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          vendedor.nombre ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          StringUtils.formatCiRuc(vendedor.ci ?? ''),
                          style: bodyTextStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 100,
                            child: Text(
                              vendedor.direccion ?? '',
                              style: bodyTextStyle,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          vendedor.celular ?? '',
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
                                vendedorController.currentRecord = vendedor;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return const VendedorFormulario(
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
                                      return EliminarVendedorDialog(
                                        vendedor: vendedorController
                                            .vendedores[index],
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
