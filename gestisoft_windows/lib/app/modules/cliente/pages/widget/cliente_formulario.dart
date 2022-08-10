import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
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

  final ciRucFC = FocusNode();
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
                  if (formKey.currentState!.validate()) {
                    clienteController
                        .saveCliente()
                        .then((value) => Modular.to.pop())
                        .whenComplete(
                            () => clienteController.findAllClientes());
                  }
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
                            onChanged: (value) {
                              clienteController.currentRecord.estado =
                                  !clienteController.currentRecord.estado!;
                            },
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
                      return RawKeyboardListener(
                        focusNode: ciRucFC,
                        onKey: (event) async {
                          if (event.physicalKey.debugName!.compareTo("Tab") ==
                              0) {
                            debugPrint("tab presionado");
                            await clienteController
                                .revisarExistenciaCi(
                                    clienteController.currentRecord.ciRuc!)
                                .then((response) =>
                                    clienteController.clienteExiste = response);
                          }
                        },
                        child: TextFormField(
                            title: "CI/RUC",
                            placeHolder: 'Ej: X.XXX.XXX-X',
                            value: clienteController.currentRecord.ciRuc ?? '',
                            onSubmited: (value) async {
                              await clienteController
                                  .revisarExistenciaCi(value)
                                  .then((response) => clienteController
                                      .clienteExiste = response);
                            },
                            suffix: clienteController.clienteExiste
                                ? const Icon(
                                    FluentIcons.warning,
                                    semanticLabel:
                                        "Este CI/RUC ya está registrado",
                                  )
                                : const SizedBox(),
                            validator: (text) {
                              if (text == null || text.length < 3) {
                                return 'El CI/RUC es obligatorio';
                              } else if (clienteController.clienteExiste) {
                                return 'Ya existe un cliente con este ruc';
                              }
                            },
                            onChanged: (value) =>
                                clienteController.currentRecord.ciRuc = value),
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
                        },
                        value: clienteController.currentRecord.nombre ?? '',
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
                        placeHolder: 'Ej: 25/12/2022',
                        enabled: false,
                        value: clienteController.currentRecord.fechaAlta ?? '',
                      ),
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
                  ),
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
