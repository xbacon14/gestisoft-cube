import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_utils/string_utils.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';

class EliminarProductoDialog extends StatefulWidget {
  const EliminarProductoDialog({Key? key, required this.producto})
      : super(key: key);
  final Producto producto;

  @override
  State<EliminarProductoDialog> createState() => _EliminarProductoDialogState();
}

class _EliminarProductoDialogState extends State<EliminarProductoDialog> {
  final ProductoController productoController = Modular.get();
  final textEditingController = TextEditingController();
  final eliminarProductoFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 300,
      ),
      title: Text(
        "Eliminar producto",
        style: FluentTheme.of(context)
            .typography
            .title!
            .copyWith(color: Colors.black.withOpacity(.8)),
      ),
      content: Form(
        key: eliminarProductoFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Digite ${StringUtils.eliminarObjetoNombreResolve(nombre: widget.producto.nombre!)} para eliminar el producto ${widget.producto.nombre}",
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(),
            ),
            TextFormField(
              title: "",
              onChanged: (String? value) {
                textEditingController.text = value!;
                setState(() {});
              },
              validator: (value) {
                if (value!.isEmpty ||
                    value !=
                        StringUtils.eliminarObjetoNombreResolve(
                            nombre: widget.producto.nombre!)) {
                  return "Digite correctamente";
                }
                return null;
              },
              placeHolder: 'Ingrese el nombre del producto a eliminar',
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          child: const Text("Volver"),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        const SizedBox(
          width: 16,
        ),
        Opacity(
          opacity: textEditingController.text ==
                  StringUtils.eliminarObjetoNombreResolve(
                      nombre: widget.producto.nombre!)
              ? 1
              : .3,
          child: FilledButton(
            child: const Text("Eliminar"),
            onPressed: () {
              if (textEditingController.text ==
                  StringUtils.eliminarObjetoNombreResolve(
                      nombre: widget.producto.nombre!)) {
                productoController
                    .eliminaProductoById(context, widget.producto.id!)
                    .whenComplete(() => productoController.findAllProductos());
              }
              Modular.to.pop();
            },
          ),
        ),
      ],
    );
  }
}
