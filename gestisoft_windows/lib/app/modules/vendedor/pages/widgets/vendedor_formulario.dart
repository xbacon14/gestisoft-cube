import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/repositories/vendedor_repository.dart';

class VendedorFormulario extends StatefulWidget {
  const VendedorFormulario({
    Key? key,
    this.editar = false,
  }) : super(key: key);

  final bool? editar;

  @override
  State<VendedorFormulario> createState() => _VendedorFormularioState();
}

class _VendedorFormularioState extends State<VendedorFormulario> {
  final VendedorController vendedorController = Modular.get();
  final formKey = GlobalKey<FormState>();
  Timer? debounce;

  final ciRucFC = FocusNode();

  @override
  void dispose() {
    debounce?.cancel();
    ciRucFC.dispose();
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
            widget.editar! ? "Editar vendedor" : "Registrar vendedor",
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
                  debugPrint(vendedorController.currentRecord.toString());
                  if (formKey.currentState!.validate()) {
                    vendedorController
                        .saveVendedor()
                        .then((value) => Modular.to.pop())
                        .whenComplete(
                            () => vendedorController.findAllVendedores());
                  } else {
                    debugPrint("formulario no valido");
                  }
                  Alert.show(
                      context: context,
                      message: "Se ha guardado el registro satisfactoriamente",
                      type: 0);
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
                        value: "${vendedorController.currentRecord.id ?? ''}",
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
                            checked: vendedorController.currentRecord.estado,
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
                        title: "CI",
                        placeHolder: 'Ej: X.XXX.XXX-X',
                        value: vendedorController.currentRecord.ci ?? '',
                        onSubmited: (value) {},
                        suffix: vendedorController.vendedorExiste
                            ? const Icon(
                                FluentIcons.warning,
                                semanticLabel: "Este CI ya está registrado",
                              )
                            : const SizedBox(),
                        validator: (text) {
                          if (text == null || text.length < 3) {
                            return 'El CI es obligatorio';
                          }
                          if (vendedorController.vendedorExiste) {
                            return 'Ya existe un vendedor con este ci';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          vendedorController.currentRecord.ci = value;
                          debugPrint(value);
                          debounce?.cancel();
                          debounce = Timer(const Duration(milliseconds: 1500),
                              () async {
                            if (value!.length > 2) {
                              await vendedorController
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
                        value: vendedorController.currentRecord.nombre ?? '',
                        onChanged: (String? value) {
                          vendedorController.currentRecord.nombre = value;
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            // FECHA ALTA
            Row(
              children: [
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: TextFormField(
                          title: "Fecha alta",
                          placeHolder: 'La fecha es definida en el servidor',
                          enabled: false,
                          value: vendedorController.currentRecord.fechaAlta !=
                                  null
                              ? DateUtil.formatDate(
                                  vendedorController.currentRecord.fechaAlta!)
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
                        value: vendedorController.currentRecord.celular ?? '',
                        onChanged: (String? value) {
                          vendedorController.currentRecord.celular = value;
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
                        value: vendedorController.currentRecord.lineaBaja ?? '',
                        onChanged: (String? value) {
                          vendedorController.currentRecord.lineaBaja = value;
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
                      value: vendedorController.currentRecord.direccion ?? '',
                      onChanged: (String? value) {
                        vendedorController.currentRecord.direccion = value;
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
                    value: vendedorController.currentRecord.observacion ?? '',
                    onChanged: (String? value) {
                      vendedorController.currentRecord.observacion = value;
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
