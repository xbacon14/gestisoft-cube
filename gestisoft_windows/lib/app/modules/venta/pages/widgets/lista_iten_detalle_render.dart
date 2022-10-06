import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta_detalle.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class ListaItenDetalleRender extends StatelessWidget {
  const ListaItenDetalleRender({
    Key? key,
    required this.ventaDetalle,
  }) : super(key: key);

  final VentaDetalle ventaDetalle;

  String getPrecioTotalItem(
      {required double cantidad, required double precioVenta}) {
    return NumberFormater.format((cantidad * precioVenta), 0);
  }

  @override
  Widget build(BuildContext context) {
    final VentaController ventaController = Modular.get();
    final itemListaStyle =
        FluentTheme.of(context).typography.body!.copyWith(color: Colors.black);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        trailing: FilledButton(
          style: ButtonStyle(
            backgroundColor: ButtonState.all(Colors.white),
            elevation: ButtonState.all(0),
          ),
          onPressed: () {
            ventaController.currentRecord.detalles!.remove(ventaDetalle);
          },
          child: Icon(
            FluentIcons.clear,
            size: 16,
            color: Colors.red,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                ventaDetalle.producto?.nombre ?? "",
                style: itemListaStyle,
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                NumberFormater.format(ventaDetalle.cantidad!, 0),
                textAlign: TextAlign.end,
                style: itemListaStyle,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 200,
                child: Text(
                  NumberFormater.format(ventaDetalle.precio!, 0),
                  style: itemListaStyle,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 200,
                child: Text(
                  getPrecioTotalItem(
                      cantidad: ventaDetalle.cantidad!,
                      precioVenta: ventaDetalle.precio!),
                  textAlign: TextAlign.end,
                  style: itemListaStyle,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
