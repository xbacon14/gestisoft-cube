import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/formulario_venta.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/lista_itenes_venta.dart';
import './venta_controller.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({Key? key}) : super(key: key);

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  final VentaController ventaController = Modular.get();
  final DataShared dataShared = Modular.get();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
              maxHeight: 800,
            ),
            child: Acrylic(
              elevation: 2,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text(
                      'Venta',
                      style:
                          FluentTheme.of(context).typography.display!.copyWith(
                                color: const Color(0xFF733924),
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FORMULARIO DE LA VENTA
                      const Expanded(
                        flex: 4,
                        child: FormularioVenta(),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        color: const Color(0xFF733924),
                        width: 2,
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton(
                                    child: Row(
                                      children: [
                                        const Icon(FluentIcons.clear),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Limpiar",
                                          style: FluentTheme.of(context)
                                              .typography
                                              .body!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => debugPrint("limpiar"),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  FilledButton(
                                    child: Row(
                                      children: [
                                        const Icon(FluentIcons.save),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Guardar",
                                          style: FluentTheme.of(context)
                                              .typography
                                              .body!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => debugPrint("guardar"),
                                  ),
                                ],
                              ),
                              ListaItenesVenta(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
