import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/popups/pdf_viewer.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:path_provider/path_provider.dart';

class FiltroProductoDialog extends StatefulWidget {
  const FiltroProductoDialog({Key? key}) : super(key: key);

  @override
  State<FiltroProductoDialog> createState() => _FiltroProductoDialogState();
}

class _FiltroProductoDialogState extends State<FiltroProductoDialog> {
  final ProductoController productoController = Modular.get();

  final desdeET = TextEditingController();
  final hastaET = TextEditingController();

  int selected = 0;
  final values = [
    "Codigo",
    "Nombre",
  ];

  String orderBy = "Codigo";

  bool isSelected(int value) {
    if (value != selected) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    desdeET.dispose();
    hastaET.dispose();
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
        "Filtros para reporte de productos",
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
          SizedBox(
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Desde"),
                const SizedBox(
                  height: 4,
                ),
                TextFormBox(
                  maxLength: 20,
                  controller: desdeET,
                  enabled: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onEditingComplete: () {},
                  validator: (text) {
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
          SizedBox(
            height: 96,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hasta"),
                const SizedBox(
                  height: 4,
                ),
                TextFormBox(
                  maxLength: 20,
                  controller: hastaET,
                  enabled: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  onEditingComplete: () {},
                  validator: (text) {
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
          TextButton(
            style: ButtonStyle(backgroundColor: ButtonState.all(Colors.white)),
            onPressed: () => productoController.verInactivos =
                !productoController.verInactivos,
            child: SizedBox(
              height: 36,
              child: Row(
                children: [
                  Observer(
                    builder: (_) {
                      return Checkbox(
                        checked: productoController.verInactivos,
                        onChanged: (value) => productoController.verInactivos =
                            !productoController.verInactivos,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Visualizar inactivos",
                    style: FluentTheme.of(context).typography.body,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 240,
            child: Row(
              children: [
                const Text("Ordenar por:"),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Combobox<String>(
                    icon: const Icon(FluentIcons.sort),
                    value: values[selected],
                    items: values
                        .map(
                          (e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (newColor) => setState(
                      () {
                        if (newColor?.compareTo("Codigo") == 0) {
                          productoController.dataProvider
                              .sort((a, b) => a.id!.compareTo(b.id!));
                          setState(
                            () {
                              selected = 0;
                            },
                          );
                        } else if (newColor?.compareTo("Nombre") == 0) {
                          productoController.dataProvider
                              .sort((a, b) => a.nombre!.compareTo(b.nombre!));
                          setState(
                            () {
                              selected = 1;
                            },
                          );
                        }
                        orderBy = newColor!;
                      },
                    ),
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
            Uint8List _bytes = await productoController.geraRelatorio(
              context: context,
              filtroDesde: desdeET.text,
              filtroHasta: hastaET.text,
              orderBy: orderBy,
              isPdf: true,
            );
            String fileName =
                "REPORTE-DE-PRODUCTOS ${DateTime.now().millisecondsSinceEpoch.toString()}";

            final directory = await getApplicationDocumentsDirectory();
            String dir = '${directory.path}\\$fileName.pdf';
            if (_bytes.isNotEmpty) {
              await File(dir).writeAsBytes(_bytes).then((file) async {
                setState(() {
                  productoController.pdf = file.readAsBytesSync();
                  productoController.pdfFile = file;
                });
              });
            } else {
              Alert.show(
                  context: context,
                  message: "No se ha podido generar el reporte",
                  type: 2);
            }
            Modular.to.push(
              FluentPageRoute(
                builder: (_) {
                  return PdfViewer(
                      bytes: _bytes,
                      fileName: fileName,
                      extension: 'pdf',
                      title: "Reporte de clientes");
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
