import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/auto_complete/auto_complete.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class FormularioVenta extends StatefulWidget {
  FormularioVenta({Key? key}) : super(key: key);

  @override
  State<FormularioVenta> createState() => _FormularioVentaState();
}

class _FormularioVentaState extends State<FormularioVenta> {
  final VentaController ventaController = Modular.get();
  final ClienteController clienteController = Modular.get();
  final VendedorController vendedorController = Modular.get();

  final codigoET = TextEditingController();
  final docNroET = TextEditingController();
  final fechaET = TextEditingController();
  final ciET = TextEditingController();
  final clienteET = TextEditingController();
  final vendedorET = TextEditingController();
  final destinoET = TextEditingController();
  final choferET = TextEditingController();
  final vehiculoET = TextEditingController();
  final descripcionET = TextEditingController();

  @override
  void initState() {
    ventaController.getProximoCodigo();
    fechaET.text = DateUtil.formatDateTimeToDate(DateTime.now());
    docNroET.text = "001-001-";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Form(
          child: Column(
        children: [
          // CODIGO
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Codigo',
                  enabled: false,
                  value: "${ventaController.currentRecord.id}",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
            ],
          ),
          // DOC NRO Y FECHA
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Doc. nro',
                  value: docNroET.text,
                  onChanged: (String? value) {
                    docNroET.text = value!;
                  },
                  placeHolder: '',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  title: 'Fecha de registro',
                  value: fechaET.text,
                  enabled: false,
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
            ],
          ),
          // CI/RUC Y CLIENTE
          Row(
            children: [
              Expanded(
                  child: AutoComplete<Cliente>(
                initialValue:
                    ventaController.currentRecord.cliente?.ciRuc ?? '',
                label: "Cliente",
                notFoundMessage: "No se ha encontrado ningun cliente",
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  color: Colors.red,
                ),
                onSuggestionSelected: (cliente) {
                  setState(() {
                    ventaController.setCliente(cliente);
                  });
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(
                      "${suggestion.ciRuc} - ${suggestion.nombre}",
                      style: FluentTheme.of(context).typography.body,
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  return clienteController.findByNombreODocumento(pattern);
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
              )),
              const SizedBox(
                width: 12,
              ),
              Observer(
                builder: (_) {
                  return Expanded(
                    child: TextFormField(
                      title: 'Cliente',
                      value:
                          ventaController.currentRecord.cliente?.nombre ?? "",
                      enabled: false,
                      onChanged: (String? value) {},
                      placeHolder: '',
                    ),
                  );
                },
              ),
            ],
          ),
          // VENDEDOR Y DESTINO
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Vendedor',
                  value: "0",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  title: 'Destino',
                  value: "0",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
            ],
          ),
          // CHOFER Y VEHICULO
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Chofer',
                  value: "0",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  title: 'Vehiculo',
                  value: "0",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
            ],
          ),
          // DESCRIPCION
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Descripcion',
                  value: "0",
                  onChanged: (String? value) {},
                  placeHolder: '',
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
