import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/autocomplete/autocomplete.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class ListaItenesVenta extends StatelessWidget {
  ListaItenesVenta({Key? key}) : super(key: key);

  final TextEditingController cantET = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final VentaController ventaController = Modular.get();
    final ProductoController productoController = Modular.get();
    return SizedBox(
        child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 300,
              height: 72,
              child: AutoComplete<Producto>(
                itemBuilder: (BuildContext context, itemData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("${itemData.id} - ${itemData.nombre} "),
                  );
                },
                label: 'Producto',
                onSuggestionSelected: (Producto? suggestion) {
                  ventaController.setProducto(producto: suggestion!);
                },
                initialValue: ventaController.producto.nombre,
                suggestionsCallback: (String pattern) async {
                  return await productoController
                      .findByNombreOCodigo(pattern)
                      .then((value) {
                    debugPrint(value.toString());
                    return value;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                title: "Cantidad",
                placeHolder: "Ej: 1",
                onChanged: (value) {
                  cantET.text = value!;
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                title: "Precio venta",
                placeHolder: "Ej: 15.000",
                onChanged: (value) {
                  cantET.text = value!;
                },
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                trailing: Icon(
                  FluentIcons.clear,
                  color: Colors.red,
                ),
                title: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text("producto"),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          "cantidad",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          "precio",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          "total",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
