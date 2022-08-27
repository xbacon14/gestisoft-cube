import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/widgets/eliminar_producto_dialog.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/widgets/producto_formulario.dart';

class ProductoTable extends StatelessWidget {
  ProductoTable({Key? key}) : super(key: key);

  final ProductoController productoController = Modular.get();

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
              // CODIGO
              SizedBox(
                width: 48,
                child: Text("Cod"),
              ),
              // NOMBRE
              Expanded(
                flex: 2,
                child: Text("Nombre"),
              ),
              // STOCK ACTUAL
              Expanded(
                flex: 2,
                child: Text("Stock actual"),
              ),
              // UNIDAD DE MEDIDA
              Expanded(
                flex: 3,
                child: Text("Unidad medida"),
              ),
              // PRECIO DE VENTA
              Expanded(
                flex: 2,
                child: Text("Precio venta"),
              ),
              // ACTIVO
              SizedBox(
                width: 120,
                child: Text("Activo"),
              ),
              // ACCIONES
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
            itemCount: productoController.productos.length,
            itemBuilder: ((context, index) {
              Producto producto = productoController.productos[index];
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
                          producto.id.toString(),
                          style: bodyTextStyle,
                        ),
                      ),
                      // NOMBRE
                      Expanded(
                        flex: 2,
                        child: Text(
                          producto.nombre ?? '',
                          style: bodyTextStyle,
                        ),
                      ),
                      // STOCK ACTUAL
                      Expanded(
                        flex: 2,
                        child: Text(
                          NumberFormater.format(producto.cantidad!, 0),
                          style: bodyTextStyle,
                        ),
                      ),
                      // UNIDAD DE MEDIDA
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                            width: 100,
                            child: Text(
                              producto.unidadMedida ?? '',
                              style: bodyTextStyle,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                      // PRECIO VENTA
                      Expanded(
                        flex: 2,
                        child: Text(
                          NumberFormater.format(producto.precioVenta!, 0),
                          style: bodyTextStyle,
                        ),
                      ),
                      // ACCIONES
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Checkbox(
                          checked: producto.estado,
                          onChanged: (value) {},
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                              onPressed: () {
                                productoController.currentRecord = producto;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return const ProductoFormulario(
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
                                      return EliminarProductoDialog(
                                        producto:
                                            productoController.productos[index],
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
