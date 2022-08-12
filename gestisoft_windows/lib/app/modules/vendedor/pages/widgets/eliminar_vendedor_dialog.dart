import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';

class EliminarVendedorDialog extends StatefulWidget {
  const EliminarVendedorDialog({
    Key? key,
    required this.vendedor,
  }) : super(key: key);

  final Vendedor vendedor;

  @override
  State<EliminarVendedorDialog> createState() => _EliminarVendedorDialogState();
}

class _EliminarVendedorDialogState extends State<EliminarVendedorDialog> {
  final VendedorController vendedorController = Modular.get();
  final textEditingController = TextEditingController();
  final eliminarVendedorFormKey = GlobalKey<FormState>();

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
        "Eliminar vendedor",
        style: FluentTheme.of(context)
            .typography
            .title!
            .copyWith(color: Colors.black.withOpacity(.8)),
      ),
      content: Form(
        key: eliminarVendedorFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Digite ${widget.vendedor.ci} para eliminar el vendedor ${widget.vendedor.nombre}",
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(),
            ),
            TextFormField(
              title: "",
              onChanged: (String? value) {
                textEditingController.text = value!;
                setState(() {});
              },
              validator: (value) {
                if (value!.isEmpty || value != widget.vendedor.ci) {
                  return "Digite correctamente";
                }
                return null;
              },
              placeHolder: 'Ingrese el CI/RUC del vendedor a eliminar',
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
          opacity: textEditingController.text == widget.vendedor.ci ? 1 : .3,
          child: FilledButton(
            child: const Text("Eliminar"),
            onPressed: () {
              if (textEditingController.text == widget.vendedor.ci) {
                vendedorController
                    .eliminaVendedorById(context, widget.vendedor.id!)
                    .whenComplete(() => vendedorController.findAllVendedores());
              }
              Modular.to.pop();
            },
          ),
        ),
      ],
    );
  }
}
