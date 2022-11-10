import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/autocomplete/autocomplete.dart';
import 'package:gestisoft_windows/app/components/popups/pdf_viewer.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';
import 'package:path_provider/path_provider.dart';

import '../../../cliente/models/cliente.dart';

class FiltroVentaDialog extends StatefulWidget {
  const FiltroVentaDialog({Key? key}) : super(key: key);

  @override
  State<FiltroVentaDialog> createState() => _FiltroVentaDialogState();
}

class _FiltroVentaDialogState extends State<FiltroVentaDialog> {
  final VentaController ventaController = Modular.get();
  final ClienteController clienteController = Modular.get();

  final TextEditingController docNroET = TextEditingController();

  DateTime dtInicio = DateTime.now();
  DateTime dtFim = DateTime.now();
  bool isPdf = true;

  @override
  void dispose() {
    docNroET.clear();
    ventaController.currentRecord = Venta().nuevo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 600,
      ),
      title: Text(
        "Filtros para reporte de venta",
        style: FluentTheme.of(context).typography.title!.copyWith(
              color: Colors.black.withOpacity(.8),
            ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 300,
                height: 72,
                child: Observer(
                  builder: (_) {
                    return AutoComplete<Cliente>(
                      itemBuilder: (BuildContext context, itemData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child:
                              Text("${itemData.ciRuc} - ${itemData.nombre} "),
                        );
                      },
                      label: 'Cliente',
                      onSuggestionSelected: (Cliente? suggestion) {
                        setState(() {
                          ventaController.setCliente(cliente: suggestion!);
                        });
                      },
                      initialValue:
                          ventaController.currentRecord.cliente?.nombre,
                      suggestionsCallback: (String pattern) async {
                        return await clienteController
                            .findByNombreODocumento(pattern)
                            .then((value) {
                          setState(() {
                            debugPrint(value.toString());
                          });
                          return value;
                        });
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextButton(
                  style: ButtonStyle(
                      padding: ButtonState.all(const EdgeInsets.all(16)),
                      backgroundColor: ButtonState.all(Colors.transparent)),
                  onPressed: () {
                    setState(() {
                      ventaController.currentRecord.cliente = Cliente().nuevo();
                    });
                  },
                  child: Icon(
                    FluentIcons.chrome_close,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Doc. nro"),
                const SizedBox(
                  height: 4,
                ),
                TextFormBox(
                  maxLength: 20,
                  controller: docNroET,
                  enabled: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onEditingComplete: () {},
                  validator: (text) {
                    if (text == null || text.length < 8) {
                      return 'El doc es obligatorio';
                    }
                    return null;
                  },
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text("Formato del reporte"),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 144,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Excel"),
                ToggleSwitch(
                  checked: isPdf,
                  onChanged: ((value) {
                    setState(() {
                      isPdf = value;
                    });
                  }),
                ),
                const Text("PDF"),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 64,
            width: 300,
            child: DatePicker(
                header: 'Desde',
                selected: dtInicio,
                onChanged: (time) {
                  setState(() {
                    dtInicio = time;
                  });
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 64,
            width: 300,
            child: DatePicker(
                header: 'Hasta',
                selected: dtFim,
                onChanged: (time) {
                  setState(() {
                    dtFim = time;
                  });
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: ButtonState.all(Colors.white),
            ),
            onPressed: () {
              ventaController.verAnuladas = !ventaController.verAnuladas;
            },
            child: Row(
              children: [
                Text(
                  "Ver anuladas",
                  style: FluentTheme.of(context).typography.body,
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Observer(
                    builder: (_) {
                      return Checkbox(
                        checked: ventaController.verAnuladas,
                        onChanged: (value) {
                          ventaController.verAnuladas =
                              !ventaController.verAnuladas;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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
          child: const Text("Generar"),
          onPressed: () async {
            ventaController.filtroPeriod =
                DateTimeRange(start: dtInicio, end: dtFim);
            Uint8List _bytes = await ventaController.geraRelatorio(
                context: context, docNro: docNroET.text, isPdf: isPdf);
            String fileName =
                "REPORTE-DE-VENTAS ${DateTime.now().millisecondsSinceEpoch.toString()}";

            if (isPdf) {
              final directory = await getApplicationDocumentsDirectory();
              String dir = '${directory.path}\\$fileName.pdf';
              if (_bytes.isNotEmpty) {
                await File(dir).writeAsBytes(_bytes).then((file) async {
                  setState(() {
                    ventaController.pdf = file.readAsBytesSync();
                    ventaController.pdfFile = file;
                  });
                });
              } else {
                Alert.show(
                    context: context,
                    message: "No se ha podido generar el reporte",
                    type: 2);
              }
            }
            Modular.to.push(
              FluentPageRoute(
                builder: (_) {
                  return PdfViewer(
                      bytes: _bytes,
                      fileName: fileName,
                      extension: 'pdf',
                      title: "Reporte de ventas");
                },
              ),
            );
            // Modular.to.pop();
          },
        ),
      ],
    );
  }
}
