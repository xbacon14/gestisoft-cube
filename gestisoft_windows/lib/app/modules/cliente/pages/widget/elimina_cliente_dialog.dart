import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';

class EliminaClienteDialog extends StatefulWidget {
  const EliminaClienteDialog({Key? key, required this.cliente})
      : super(key: key);
  final Cliente cliente;

  @override
  State<EliminaClienteDialog> createState() => _EliminaClienteDialogState();
}

class _EliminaClienteDialogState extends State<EliminaClienteDialog> {
  final ClienteController clienteController = Modular.get();
  final textEditingController = TextEditingController();
  final eliminarClienteFormKey = GlobalKey<FormState>();

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
        "Eliminar cliente",
        style: FluentTheme.of(context)
            .typography
            .title!
            .copyWith(color: Colors.black.withOpacity(.8)),
      ),
      content: Form(
        key: eliminarClienteFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Digite ${widget.cliente.ciRuc} para eliminar el cliente ${widget.cliente.nombre}",
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(),
            ),
            TextFormField(
              title: "",
              onChanged: (String? value) {
                textEditingController.text = value!;
                setState(() {});
              },
              validator: (value) {
                if (value!.isEmpty || value != widget.cliente.ciRuc) {
                  return "Digite correctamente";
                }
                return null;
              },
              placeHolder: 'Ingrese el CI/RUC del cliente a eliminar',
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
          opacity: textEditingController.text == widget.cliente.ciRuc ? 1 : .3,
          child: FilledButton(
            child: const Text("Eliminar"),
            onPressed: () {
              if (textEditingController.text == widget.cliente.ciRuc) {
                clienteController
                    .eliminaClienteById(context, widget.cliente.id!)
                    .whenComplete(() => clienteController.findAllClientes());
              }
              Modular.to.pop();
            },
          ),
        ),
      ],
    );
  }
}
