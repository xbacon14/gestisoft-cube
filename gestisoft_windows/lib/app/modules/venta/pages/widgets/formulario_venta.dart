import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/autocomplete/autocomplete.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';

class FormularioVenta extends StatefulWidget {
  const FormularioVenta({Key? key}) : super(key: key);

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

  Timer? debounce;
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  void initState() {
    ventaController.getProximoCodigo();
    fechaET.text = DateUtil.formatDateTimeToDate(DateTime.now());
    docNroET.text = "001-001-";
    super.initState();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
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
                flex: 2,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CLIENTE AUTOSUGGEST
              SizedBox(
                width: 300,
                height: 72,
                child: AutoComplete<Cliente>(
                  itemBuilder: (BuildContext context, itemData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${itemData.ciRuc} - ${itemData.nombre} "),
                    );
                  },
                  label: 'Cliente',
                  onSuggestionSelected: (Cliente? suggestion) {
                    setState(() {
                      ventaController.setCliente(cliente: suggestion!);
                    });
                  },
                  initialValue: ventaController.currentRecord.cliente?.nombre,
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
              )
            ],
          ),
          // VENDEDOR Y DESTINO
          Row(
            children: [
              SizedBox(
                width: 300,
                height: 72,
                child: AutoComplete<Vendedor>(
                  itemBuilder: (BuildContext context, itemData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${itemData.ci} - ${itemData.nombre} "),
                    );
                  },
                  label: 'Vendedor',
                  onSuggestionSelected: (Vendedor? suggestion) {
                    setState(() {
                      ventaController.setVendedor(vendedor: suggestion!);
                    });
                  },
                  initialValue: ventaController.currentRecord.vendedor?.nombre,
                  suggestionsCallback: (String pattern) async {
                    return await vendedorController
                        .findByNombreODocumento(pattern)
                        .then((value) {
                      setState(() {
                        debugPrint(value.toString());
                      });
                      return value;
                    });
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
                      ventaController.currentRecord.vendedor = Vendedor.nuevo();
                    });
                  },
                  child: Icon(
                    FluentIcons.chrome_close,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  title: 'Destino',
                  maxChar: 20,
                  value: destinoET.text,
                  onChanged: (String? value) {},
                  placeHolder: 'Ingrese el destino de la venta aquí',
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
                  value: choferET.text,
                  onChanged: (String? value) {},
                  placeHolder: 'Nombre del chofer',
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  title: 'Vehiculo',
                  value: vehiculoET.text,
                  onChanged: (String? value) {},
                  placeHolder: 'Ingrese el vehículo aquí',
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
                  value: descripcionET.text,
                  onChanged: (String? value) {},
                  placeHolder: 'Ingrese alguna descripción aquí',
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
