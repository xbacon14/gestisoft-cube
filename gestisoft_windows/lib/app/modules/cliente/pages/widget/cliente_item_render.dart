import 'package:fluent_ui/fluent_ui.dart';

class ClienteItemRender extends StatelessWidget {
  const ClienteItemRender({Key? key, required this.nombre}) : super(key: key);

  final String nombre;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.red.withOpacity(.4),
          borderRadius: BorderRadius.circular(6)),
      child: ListTile(title: Text(nombre)),
    );
  }
}
