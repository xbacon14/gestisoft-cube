import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';

class ProductoFormulario extends StatefulWidget {
  const ProductoFormulario({Key? key, this.editar = false}) : super(key: key);

  final bool? editar;

  @override
  State<ProductoFormulario> createState() => _ProductoFormularioState();
}

class _ProductoFormularioState extends State<ProductoFormulario> {
  final ProductoController productoController = Modular.get();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (!widget.editar!) {
      productoController.currentRecord.unidadMedida =
          productoController.values[0];
    }
    super.initState();
  }

  @override
  void dispose() {
    productoController.currentRecord = Producto.nuevo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 800, maxHeight: 500),
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
            widget.editar! ? "Editar producto" : "Registrar producto",
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
                  productoController.currentRecord = Producto.nuevo();
                  Modular.to.pop();
                },
              ),
              const SizedBox(
                width: 16,
              ),
              FilledButton(
                child: const Text("Guardar"),
                onPressed: () {
                  debugPrint(productoController.currentRecord.toString());
                  if (formKey.currentState!.validate()) {
                    productoController.save().then((value) {
                      Alert.show(
                          context: context,
                          message:
                              "Se ha guardado el registro del producto satisfactoriamente",
                          type: 0);
                      Modular.to.pop();
                    }).whenComplete(
                        () => productoController.findAllProductos());
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
                        value: "${productoController.currentRecord.id ?? ''}",
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
                            checked: productoController.currentRecord.estado,
                            onChanged: (value) {
                              setState(() {
                                productoController.currentRecord.estado =
                                    !productoController.currentRecord.estado!;
                              });
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
                      return TextFormField(
                        title: "Nombre",
                        placeHolder: 'Ej: Arena',
                        value: productoController.currentRecord.nombre ?? '',
                        onSubmited: (value) {},
                        validator: (text) {
                          if (text == null || text.length < 3) {
                            return 'El nombre es obligatorio';
                          } else if (text.length > 8) {
                            return 'El nombre no puede tener mas que 8 caracteres';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          productoController.currentRecord.nombre = value;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Observer(
                    builder: (_) {
                      return TextFormField(
                        title: "Precio de venta",
                        placeHolder: 'Ej: 2000.00',
                        value: NumberFormater.format(
                            productoController.currentRecord.precioVenta!, 0),
                        onSubmited: (value) {},
                        validator: (text) {
                          if (text == null || text.length < 3) {
                            return 'El precio de venta es obligatorio';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          double? valor = double.tryParse(value!);
                          productoController.currentRecord.precioVenta = valor;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            //CANTIDAD Y UNIDAD DE MEDIDA
            Row(
              children: [
                Observer(
                  builder: (_) {
                    return Expanded(
                      flex: 2,
                      child: TextFormField(
                        title: "Cantidad",
                        placeHolder: 'Ej: 1',
                        value: '',
                        onChanged: (String? value) {
                          double? valor = double.tryParse(value!);
                          productoController.currentRecord.cantidad = valor;
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Unidad de medida"),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.red.withOpacity(.7)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Combobox<String>(
                              placeholder: const Text("Unidad de medida"),
                              icon: const Icon(FluentIcons.sort),
                              value: productoController
                                  .values[productoController.selected],
                              items: productoController.values
                                  .map(
                                    (e) => ComboboxItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newColor) => setState(
                                () {
                                  if (newColor!.compareTo("METROS CÚBICOS") ==
                                      0) {
                                    productoController.selected = 0;
                                  } else if (newColor.compareTo("UNIDADES") ==
                                      0) {
                                    productoController.selected = 1;
                                  }

                                  productoController
                                      .currentRecord.unidadMedida = newColor;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            //OBSERVACION Y FECHA DE REGISTRO
            Row(
              children: [
                Observer(
                  builder: (_) {
                    return Expanded(
                      child: TextFormField(
                        title: "Observacion",
                        placeHolder: 'Ej: Ultrafina',
                        value:
                            productoController.currentRecord.observacion ?? '',
                        onChanged: (String? value) {
                          productoController.currentRecord.observacion = value;
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
                        title: "Fecha de registro",
                        enabled: false,
                        placeHolder:
                            'La fecha de registro es definida en el servidor',
                        value: productoController.currentRecord.fechaRegistro ??
                            '',
                        onChanged: (String? value) {},
                        validator: (value) => null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
