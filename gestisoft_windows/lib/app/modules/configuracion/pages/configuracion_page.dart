import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import './configuracion_controller.dart';

class ConfiguracionPage extends StatelessWidget {
  final ConfiguracionController controller = Modular.get();

  ConfiguracionPage({
    Key? key,
    required ConfiguracionController controller,
  }) : super(key: key);

  final fechaET = TextEditingController(text: DateTime.now().toString());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 96,
        child: TextFormField(
            onChanged: (String? value) {},
            placeHolder: 'Ingrese algun dato aqui',
            value: fechaET.text,
            title: 'Campo aleatorio para el profe Alex',
            onSubmited: (value) =>
                Alert.show(context: context, message: value, type: 0)),
      ),
    );
  }
}
