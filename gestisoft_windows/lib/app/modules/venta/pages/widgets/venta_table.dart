import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/cancelar_venta_dialog.dart';

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
                child: Text(
                  "Cod",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Nombre cliente",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Nombre vendedor",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Fecha venta",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Direccion",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Estado",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  "Acciones",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Observer(
            builder: (_) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 690,
                child: ListView.builder(
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
                              child: Text(
                                venta.cliente?.nombre ?? '',
                                style: bodyTextStyle,
                              ),
                            ),
                            // CI/RUC
                            Expanded(
                              child: Text(
                                venta.vendedor?.nombre ?? "",
                                style: bodyTextStyle,
                              ),
                            ),
                            // DIRECCION
                            Expanded(
                              child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    DateUtil.formatDate(venta.fecha!),
                                    style: bodyTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Expanded(
                              child: Text(
                                venta.observacion ?? '',
                                style: bodyTextStyle,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: Checkbox(
                                checked: !venta.estado!,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: !venta.estado!
                                  ? Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        "Cancelado",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            ButtonState.all(Colors.red),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return CancelarVentaDialog(
                                                venta: ventaController
                                                    .dataProvider[index],
                                              );
                                            });
                                      },
                                      child: const Text("Cancelar"),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
