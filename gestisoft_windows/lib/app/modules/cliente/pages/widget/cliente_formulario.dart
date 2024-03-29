import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/text_utils/string_utils.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';

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
  final ClienteController clienteController = Modular.get();
  final formKey = GlobalKey<FormState>();
  Timer? debounce;

  final ciRucFC = FocusNode();

  @override
  void dispose() {
    debounce?.cancel();
    ciRucFC.dispose();
    clienteController.currentRecord = Cliente().nuevo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 640),
      style: const ContentDialogThemeData(
        decoration: BoxDecoration(
          color: Color(0xFFFDF9E6),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.editar! ? "Editar cliente" : "Registrar cliente",
            style: FluentTheme.of(context)
                .typography
                .title!
                .copyWith(color: Colors.black.withOpacity(.8)),
          ),
          Row(
            children: [
              OutlinedButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
              const SizedBox(
                width: 16,
              ),
              FilledButton(
                child: const Text("Guardar"),
                onPressed: () {
                  debugPrint(clienteController.currentRecord.toString());
                  if (formKey.currentState!.validate()) {
                    clienteController.saveCliente().then((value) {
                      Modular.to.pop();
                      Alert.show(
                          context: context,
                          message:
                              "Se ha guardado el registro del cliente satisfactoriamente",
                          type: 0);
                    }).whenComplete(() => clienteController.findAllClientes());
                  } else if (clienteController.clienteExiste) {
                    Alert.show(
                        context: context,
                        message: "Este cliente ya existe",
                        type: 2);
                  } else {
                    debugPrint("formulario no valido");
                  }
                  ;
                },
              ),
            ],
          ),
        ],
      ),
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // CODIGO Y ACTIVO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Observer(
                  builder: (_) {
                    return SizedBox(
                      width: 96,
                      child: TextFormField(
                        title: 'Código',
                        placeHolder: '',
                        enabled: false,
                        value: "${clienteController.currentRecord.id ?? ''}",
                        onChanged: (String? value) {},
                        validator: ((value) => null),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  height: 56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Activo"),
                      Observer(
                        builder: (_) {
                          return Checkbox(
                            checked: clienteController.currentRecord.estado,
                            onChanged: (value) {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            // NOMBRE Y CI/RUC
            Row(
              children: [
                Expanded(
                  child: Observer(
                    builder: (_) {
                      return TextFormField(
                        title: "CI/RUC",
                        placeHolder: 'Ej: X.XXX.XXX-X',
                        value: clienteController.currentRecord.ciRuc ?? '',
                        onSubmited: (value) {},
                        suffix: clienteController.clienteExiste
                            ? const Icon(
                                FluentIcons.warning,
                                semanticLabel: "Este CI/RUC ya está registrado",
                              )
                            : const SizedBox(),
                        validator: (text) {
                          if (text == null || text.length < 3) {
                            return 'El CI/RUC es obligatorio';
                          }
                          if (clienteController.clienteExiste) {
                            return 'Ya existe un cliente con este ruc';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          clienteController.currentRecord.ciRuc = value;
                          debugPrint(value);
                          debounce?.cancel();
                          debounce = Timer(const Duration(milliseconds: 1500),
                              () async {
                            if (value!.length > 2) {
                              await clienteController
                                  .revisarExistenciaCi(value);
                            }
                          });
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                      flex: 2,
                      child: TextFormField(
                        title: "Nombre",
                        placeHolder: 'Ej: Fulano',
                        validator: (text) {
                          if (text == null || text.length < 3) {
                            return 'El nombre es obligatorio';
                          }
                          return null;
                        },
                        value: clienteController.currentRecord.nombre ?? '',
                        onChanged: (String? value) {
                          clienteController.currentRecord.nombre = value;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            //EMAIL Y FECHA ALTA
            Row(
              children: [
                Observer(
                  builder: (_) {
                    return Expanded(
                      flex: 2,
                      child: TextFormField(
                        title: "Email",
                        placeHolder: 'Ej: hola@cube.com',
                        value: clienteController.currentRecord.email ?? '',
                        onChanged: (String? value) {
                          clienteController.currentRecord.email = value;
                        },
                        validator: (value) {
                          if (!StringUtils.emailValidator(value!) &&
                              value.length > 4) {
                            return "Este campo debe de ser un e-mail";
                          }
                          return null;
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: TextFormField(
                          title: "Fecha alta",
                          placeHolder: 'La fecha es definida en el servidor',
                          enabled: false,
                          value: clienteController.currentRecord.fechaAlta !=
                                  null
                              ? DateUtil.formatDate(
                                  clienteController.currentRecord.fechaAlta!)
                              : '',
                          onChanged: (String? value) {},
                          validator: (value) => null),
                    );
                  },
                ),
              ],
            ),
            //CELULAR Y LINEA BAJA
            Row(
              children: [
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: TextFormField(
                        title: "Celular",
                        placeHolder: 'Ej: (09xx) xxx xxx',
                        value: clienteController.currentRecord.celular ?? '',
                        onChanged: (String? value) {
                          clienteController.currentRecord.celular = value;
                        },
                        validator: ((value) => null),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 16,
                ),
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: TextFormField(
                        title: "Linea baja",
                        placeHolder: 'Ej: (046) xxx xxx',
                        value: clienteController.currentRecord.lineaBaja ?? '',
                        onChanged: (String? value) {
                          clienteController.currentRecord.lineaBaja = value;
                        },
                        validator: (value) => null,
                      ),
                    );
                  },
                ),
              ],
            ),
            // DIRECCION
            Observer(
              builder: (_) {
                return SizedBox(
                  height: 86,
                  child: TextFormField(
                      title: "Dirección",
                      placeHolder: 'Ej: Av Paraguay',
                      value: clienteController.currentRecord.direccion ?? '',
                      onChanged: (String? value) {
                        clienteController.currentRecord.direccion = value;
                      },
                      validator: (value) => null),
                );
              },
            ),
            // OBSERVACION
            Observer(
              builder: (_) {
                return SizedBox(
                  height: 86,
                  child: TextFormField(
                    title: "Observacion",
                    placeHolder: 'Ej: Frente a la plaza',
                    value: clienteController.currentRecord.observacion ?? '',
                    onChanged: (String? value) {
                      clienteController.currentRecord.observacion = value;
                    },
                    validator: ((value) => null),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
