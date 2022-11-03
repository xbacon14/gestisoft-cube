import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/configuracion_controller.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/configuracion_page.dart';

class TruncateDialog extends StatefulWidget {
  const TruncateDialog({Key? key}) : super(key: key);

  @override
  State<TruncateDialog> createState() => _TruncateDialogState();
}

class _TruncateDialogState extends State<TruncateDialog> {
  final ConfiguracionController configuracionController = Modular.get();
  final DataShared dataShared = Modular.get();
  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(
        maxWidth: 400,
        maxHeight: 300,
      ),
      title: Text(
        "Limpiar base de datos",
        style: FluentTheme.of(context).typography.title!.copyWith(
              color: Colors.black.withOpacity(.8),
            ),
      ),
      content: Text(
        "Estas seguro que deseas eliminar todos los registros de la base de datos?",
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
          child: const Text("Eliminar datos"),
          onPressed: () {
            configuracionController
                .truncateTables(context)
                .then((value) => dataShared.nombreEmpresa = "SIN DEFINIR");
            Modular.to.pop();
          },
        ),
      ],
    );
  }
}
