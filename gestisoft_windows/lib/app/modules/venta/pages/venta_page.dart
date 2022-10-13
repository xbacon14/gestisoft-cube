import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/autocomplete/autocomplete.dart';
import 'package:gestisoft_windows/app/components/date/date_util.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/components/text_utils/number_formatter.dart';
import 'package:gestisoft_windows/app/components/text_utils/text_input_number.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/components/ui/empty_state.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta_detalle.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/lista_iten_detalle_render.dart';
import './venta_controller.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({Key? key}) : super(key: key);

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  final VentaController ventaController = Modular.get();
  final DataShared dataShared = Modular.get();
  final ClienteController clienteController = Modular.get();
  final VendedorController vendedorController = Modular.get();
  final ProductoController productoController = Modular.get();

  final formVentaKey = GlobalKey<FormState>();

  // FORMULARIO VENTA

  final cantFN = FocusNode();
  final precioVentaFN = FocusNode();
  final docNroFN = FocusNode();
  final fechaFN = FocusNode();
  final choferFN = FocusNode();
  final vehiculoFN = FocusNode();
  final descripcionFN = FocusNode();

  @override
  void initState() {
    ventaController.getProximoCodigo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1200,
              maxHeight: 720,
            ),
            child: Column(
              children: [
                Acrylic(
                  elevation: 2,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Venta',
                            style: FluentTheme.of(context)
                                .typography
                                .display!
                                .copyWith(
                                  color: const Color(0xFF733924),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FORMULARIO DE LA VENTA
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                child: Form(
                                    key: formVentaKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: [
                                        // CODIGO
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Código"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .idVentaET,
                                                      enabled: false,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // child: Observer(
                                              //   builder: (_) {
                                              //     return TextFormField(
                                              //       title: 'Codigo',
                                              //       enabled: false,
                                              //       value: ventaController
                                              //           .idVentaET.text,
                                              //       onChanged:
                                              //           (String? value) {},
                                              //       validator: ((value) =>
                                              //           null),
                                              //       placeHolder: '',
                                              //     );
                                              //   },
                                              // ),
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
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Doc. nro"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .docNroET,
                                                      enabled: true,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.length < 8) {
                                                          return 'El doc es obligatorio';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Fecha de registro"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .fechaET,
                                                      enabled: false,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // CI/RUC Y CLIENTE
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // CLIENTE AUTOSUGGEST
                                            SizedBox(
                                              width: 300,
                                              height: 72,
                                              child: Observer(
                                                builder: (_) {
                                                  return AutoComplete<Cliente>(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            itemData) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        child: Text(
                                                            "${itemData.ciRuc} - ${itemData.nombre} "),
                                                      );
                                                    },
                                                    label: 'Cliente',
                                                    onSuggestionSelected:
                                                        (Cliente? suggestion) {
                                                      setState(() {
                                                        ventaController
                                                            .setCliente(
                                                                cliente:
                                                                    suggestion!);
                                                      });
                                                    },
                                                    initialValue:
                                                        ventaController
                                                            .currentRecord
                                                            .cliente
                                                            ?.nombre,
                                                    suggestionsCallback:
                                                        (String pattern) async {
                                                      return await clienteController
                                                          .findByNombreODocumento(
                                                              pattern)
                                                          .then((value) {
                                                        setState(() {
                                                          debugPrint(
                                                              value.toString());
                                                        });
                                                        return value;
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    padding: ButtonState.all(
                                                        const EdgeInsets.all(
                                                            16)),
                                                    backgroundColor:
                                                        ButtonState.all(Colors
                                                            .transparent)),
                                                onPressed: () {
                                                  setState(() {
                                                    ventaController
                                                            .currentRecord
                                                            .cliente =
                                                        Cliente().nuevo();
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
                                              child: Observer(
                                                builder: (_) {
                                                  return AutoComplete<Vendedor>(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            itemData) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8),
                                                        child: Text(
                                                            "${itemData.ci} - ${itemData.nombre} "),
                                                      );
                                                    },
                                                    label: 'Vendedor',
                                                    onSuggestionSelected:
                                                        (Vendedor? suggestion) {
                                                      setState(() {
                                                        ventaController
                                                            .setVendedor(
                                                                vendedor:
                                                                    suggestion!);
                                                      });
                                                    },
                                                    initialValue:
                                                        ventaController
                                                            .currentRecord
                                                            .vendedor
                                                            ?.nombre,
                                                    suggestionsCallback:
                                                        (String pattern) async {
                                                      return await vendedorController
                                                          .findByNombreODocumento(
                                                              pattern)
                                                          .then((value) {
                                                        setState(() {
                                                          debugPrint(
                                                              value.toString());
                                                        });
                                                        return value;
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    padding: ButtonState.all(
                                                        const EdgeInsets.all(
                                                            16)),
                                                    backgroundColor:
                                                        ButtonState.all(Colors
                                                            .transparent)),
                                                onPressed: () {
                                                  setState(() {
                                                    ventaController
                                                            .currentRecord
                                                            .vendedor =
                                                        Vendedor.nuevo();
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
                                        // CHOFER Y VEHICULO
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Chofer"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .choferET,
                                                      enabled: true,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.length < 8) {
                                                          return 'El chofer es obligatorio';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Vehiculo"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .vehiculoET,
                                                      enabled: true,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.length < 8) {
                                                          return 'El vehiculo es obligatorio';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // DESCRIPCION
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 96,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text("Descripcion"),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    TextFormBox(
                                                      maxLength: 20,
                                                      controller:
                                                          ventaController
                                                              .descripcionET,
                                                      enabled: true,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 12),
                                                      onEditingComplete: () {},
                                                      validator: (text) {
                                                        if (text == null ||
                                                            text.length < 8) {
                                                          return 'La descripcion es obligatoria';
                                                        }
                                                        return null;
                                                      },
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.red,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              color: const Color(0xFF733924),
                              width: 2,
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FilledButton(
                                          child: Row(
                                            children: [
                                              const Icon(FluentIcons.clear),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Limpiar",
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .body!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            ventaController.limpiarCampos();
                                            ventaController.getProximoCodigo();
                                          },
                                        ),
                                        const SizedBox(
                                          width: 24,
                                        ),
                                        FilledButton(
                                          child: Row(
                                            children: [
                                              const Icon(FluentIcons.save),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Guardar",
                                                style: FluentTheme.of(context)
                                                    .typography
                                                    .body!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            if (ventaController.currentRecord
                                                .cliente!.nombre!.isEmpty) {
                                              Alert.show(
                                                  context: context,
                                                  message:
                                                      "El cliente es obligatorio",
                                                  type: 1);
                                              return;
                                            } else if (ventaController
                                                .currentRecord
                                                .vendedor!
                                                .nombre!
                                                .isEmpty) {
                                              Alert.show(
                                                  context: context,
                                                  message:
                                                      "El vendedor es obligatorio",
                                                  type: 1);
                                              return;
                                            } else if (ventaController
                                                        .currentRecord
                                                        .detalles ==
                                                    null ||
                                                ventaController.currentRecord
                                                    .detalles!.isEmpty) {
                                              Alert.show(
                                                  context: context,
                                                  message:
                                                      "La venta no se puede finalizar sin itenes",
                                                  type: 1);
                                              return;
                                            } else if (formVentaKey
                                                .currentState!
                                                .validate()) {
                                              ventaController
                                                      .currentRecord.chofer =
                                                  ventaController.choferET.text;
                                              ventaController
                                                      .currentRecord.vehiculo =
                                                  ventaController
                                                      .vehiculoET.text;
                                              ventaController.currentRecord
                                                      .observacion =
                                                  ventaController
                                                      .descripcionET.text;
                                              ventaController
                                                      .currentRecord.docNro =
                                                  ventaController.docNroET.text;
                                              ventaController
                                                  .guardarVenta(context)
                                                  .whenComplete(() {
                                                ventaController.limpiarCampos();
                                                ventaController
                                                    .getProximoCodigo();
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    SizedBox(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            // BUSCADOR DE PRODUCTOS
                                            SizedBox(
                                                width: 300,
                                                height: 72,
                                                child: Observer(
                                                  builder: (_) {
                                                    return AutoComplete<
                                                        Producto>(
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              itemData) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: Text(
                                                              "${itemData.id} - ${itemData.nombre} "),
                                                        );
                                                      },
                                                      label: 'Producto',
                                                      onSuggestionSelected:
                                                          (Producto?
                                                              suggestion) {
                                                        ventaController
                                                            .setProducto(
                                                                producto:
                                                                    suggestion!)
                                                            .then((value) {
                                                          setState(() {
                                                            ventaController
                                                                    .produtoSeleccionado =
                                                                true;
                                                            ventaController
                                                                .detalleActual
                                                                .cantidad = 1;
                                                            ventaController
                                                                    .detalleActual
                                                                    .precio =
                                                                suggestion
                                                                    .precioVenta;
                                                            ventaController
                                                                    .detalleActual
                                                                    .producto =
                                                                suggestion;
                                                            ventaController
                                                                    .precioVentaET
                                                                    .text =
                                                                NumberFormater.format(
                                                                    suggestion
                                                                        .precioVenta!,
                                                                    0);
                                                          });
                                                        });
                                                        cantFN.requestFocus();
                                                      },
                                                      initialValue:
                                                          ventaController
                                                              .detalleActual
                                                              .producto
                                                              ?.nombre,
                                                      suggestionsCallback:
                                                          (String
                                                              pattern) async {
                                                        return await productoController
                                                            .findByNombreOCodigo(
                                                                pattern)
                                                            .then((value) {
                                                          debugPrint(
                                                              value.toString());
                                                          return value;
                                                        });
                                                      },
                                                    );
                                                  },
                                                )),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            // CAMPO DE ENTRADA DE TEXTO DE CANTIDAD
                                            Expanded(
                                              child: Observer(
                                                builder: (_) {
                                                  return NumberInputCustom(
                                                    labelText: 'Cantidad',
                                                    enabled: true,
                                                    precision: 0,
                                                    focusNode: cantFN,
                                                    numberValue: ventaController
                                                        .detalleActual.cantidad,
                                                    controller:
                                                        ventaController.cantET,
                                                    onChanged: (value) {
                                                      ventaController
                                                          .detalleActual
                                                          .cantidad = value;
                                                    },
                                                    onSubmited: (value) {
                                                      precioVentaFN
                                                          .requestFocus();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            // CAMPO DE ENTRADA DE TEXTO DE PRECIO DE VENTA
                                            Expanded(
                                              flex: 2,
                                              child: Observer(
                                                builder: (_) {
                                                  return NumberInputCustom(
                                                    labelText: 'Precio venta',
                                                    enabled: ventaController
                                                        .produtoSeleccionado,
                                                    focusNode: precioVentaFN,
                                                    precision: 0,
                                                    numberValue: ventaController
                                                            .detalleActual
                                                            .producto
                                                            ?.precioVenta ??
                                                        0,
                                                    controller: ventaController
                                                        .precioVentaET,
                                                    onChanged: (value) {
                                                      ventaController
                                                          .detalleActual
                                                          .precio = value;
                                                    },
                                                    onSubmited: (value) {
                                                      ventaController
                                                          .addItemProducto(
                                                              item: ventaController
                                                                  .detalleActual)
                                                          .then((value) {
                                                        ventaController.cantET
                                                            .clear();
                                                        ventaController
                                                            .precioVentaET
                                                            .clear();
                                                      });
                                                      ventaController
                                                              .detalleActual =
                                                          VentaDetalle.nuevo();
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        // COLUMNAS LISTA
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            children: const [
                                              Expanded(
                                                flex: 2,
                                                child: Text("Descripcion"),
                                              ),
                                              Expanded(
                                                child: Text("Cantidad"),
                                              ),
                                              Expanded(
                                                child: Text("Precio Unitario"),
                                              ),
                                              Expanded(
                                                child: Text("Precio Total"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // LISTA DE ITENES
                                        Observer(
                                          builder: (_) {
                                            return ventaController.listaVacia
                                                ? const EmptyState(
                                                    texto:
                                                        "Lista vacia, agregue algun producto",
                                                    icono: Icon(
                                                      FluentIcons
                                                          .remove_from_shopping_list,
                                                      size: 48,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 440,
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: ventaController
                                                          .currentRecord
                                                          .detalles
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListaItenDetalleRender(
                                                            ventaDetalle:
                                                                ventaController
                                                                    .currentRecord
                                                                    .detalles![index]);
                                                      },
                                                    ),
                                                  );
                                          },
                                        ),
                                        // TOTALIZADORES
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Totales:",
                                              style: FluentTheme.of(context)
                                                  .typography
                                                  .title,
                                            ),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                            Container(
                                              width: 144,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Observer(
                                                builder: (context) => Text(
                                                  ventaController
                                                      .vlTotalListaDetalle(),
                                                  style: FluentTheme.of(context)
                                                      .typography
                                                      .bodyStrong!
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(.8)),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      dataShared.version,
                      style: FluentTheme.of(context).typography.subtitle,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
