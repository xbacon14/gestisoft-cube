import 'package:fluent_ui/fluent_ui.dart';

class ClienteFormulario extends StatefulWidget {
  const ClienteFormulario({
    Key? key,
    this.editar = false,
  }) : super(key: key);

  final bool? editar;

  @override
  State<ClienteFormulario> createState() => _ClienteFormularioState();
}

class _ClienteFormularioState extends State<ClienteFormulario> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ContentDialog(
        title: Text(
          widget.editar! ? "Editar cliente" : "Registrar cliente",
        ),
        content: Form(
          child: Column(
            children: [
              Row(
                children: const [
                  Text("Nombre"),
                  Text("Direccion"),
                  Text("Observacion"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
