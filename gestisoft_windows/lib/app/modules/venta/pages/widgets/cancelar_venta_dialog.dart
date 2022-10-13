import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class CancelarVentaDialog extends StatefulWidget {
  const CancelarVentaDialog({Key? key, required this.venta}) : super(key: key);

  final Venta venta;

  @override
  State<CancelarVentaDialog> createState() => _CancelarVentaDialogState();
}

class _CancelarVentaDialogState extends State<CancelarVentaDialog> {
  final VentaController ventaController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 300,
      ),
      title: Text(
        "Cancelar venta",
        style: FluentTheme.of(context).typography.title!.copyWith(
              color: Colors.black.withOpacity(.8),
            ),
      ),
      content: Text(
        "Estas seguro que deseas cancelar la venta codigo ${widget.venta.id} ?",
        style: FluentTheme.of(context).typography.bodyLarge!.copyWith(),
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
        FilledButton(
          child: const Text("Cancelar"),
          onPressed: () {
            ventaController
                .cancelarVenta(context, widget.venta.id!)
                .whenComplete(() => ventaController.findAllVentas(context));
            Modular.to.pop();
          },
        ),
      ],
    );
  }
}
