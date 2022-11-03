import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/components/text_field/text_form_field.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/widgets/truncate_dialog.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';
import './configuracion_controller.dart';

class ConfiguracionPage extends StatefulWidget {
  ConfiguracionPage({
    Key? key,
    required ConfiguracionController controller,
  }) : super(key: key);

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  final ConfiguracionController controller = Modular.get();

  final empresaFormKey = GlobalKey<FormState>();

  final ConfiguracionController configuracionController = Modular.get();

  final DataShared dataShared = Modular.get();

  final HomeController homeController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
              maxHeight: 800,
            ),
            child: Acrylic(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: empresaFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Datos de la Empresa",
                        style: FluentTheme.of(context).typography.title,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // NOMBRE DE LA EMPRESA
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Nombre de la empresa*',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value:
                                configuracionController.currentRecord?.nombre ??
                                    '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.nombre =
                                  value;
                            },
                            validator: (text) {
                              if (text == null || text.length < 3) {
                                return 'El nombre es obligatorio y debe tener por lo menos 5 carácteres';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      // RUC
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'RUC*',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value: configuracionController.currentRecord?.ruc ??
                                '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.ruc =
                                  value;
                            },
                            validator: (text) {
                              if (text == null || text.length < 3) {
                                return 'El RUC es obligatorio';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      // CELULAR
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Celular',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value: configuracionController
                                    .currentRecord?.celular ??
                                '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.celular =
                                  value;
                            },
                            validator: ((value) => null),
                          );
                        },
                      ),
                      // LINEA BAJA
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Linea baja',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value: configuracionController
                                    .currentRecord?.lineaBaja ??
                                '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.lineaBaja =
                                  value;
                            },
                            validator: ((value) => null),
                          );
                        },
                      ),
                      // EMAIL
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Email',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value:
                                configuracionController.currentRecord?.email ??
                                    '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.email =
                                  value;
                            },
                            validator: ((value) => null),
                          );
                        },
                      ),
                      // CIUDAD
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Ciudad',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value:
                                configuracionController.currentRecord?.ciudad ??
                                    '',
                            onChanged: (String? value) {
                              configuracionController.currentRecord?.ciudad =
                                  value;
                            },
                            validator: ((value) => null),
                          );
                        },
                      ),
                      // OBSERVACION
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            title: 'Observacion',
                            placeHolder: '',
                            enabled: configuracionController.editarCampos,
                            value: configuracionController
                                    .currentRecord?.observacion ??
                                '',
                            onChanged: (String? value) {
                              configuracionController
                                  .currentRecord?.observacion = value;
                            },
                            validator: ((value) => null),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // FilledButton(
                          //   style: ButtonStyle(
                          //       backgroundColor: ButtonState.all(Colors.red)),
                          //   onPressed: () {
                          //     configuracionController.limpiarCampos();
                          //     setState(() {});
                          //   },
                          //   child: Row(
                          //     children: const [
                          //       Icon(FluentIcons.delete),
                          //       SizedBox(
                          //         width: 8,
                          //       ),
                          //       Text("Limpiar campos"),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 16,
                          // ),
                          Observer(
                            builder: (_) {
                              return Visibility(
                                visible: configuracionController.editarCampos,
                                replacement: FilledButton(
                                  onPressed: () {
                                    configuracionController.editarCampos =
                                        !configuracionController.editarCampos;
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(FluentIcons.save),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Editar"),
                                    ],
                                  ),
                                ),
                                child: FilledButton(
                                  onPressed: () {
                                    if (empresaFormKey.currentState!
                                        .validate()) {
                                      configuracionController.currentRecord!
                                          .configuracionEfectuada = true;
                                      configuracionController
                                          .save(context)
                                          .then((value) {
                                        if (value.configuracionEfectuada!) {
                                          dataShared.nombreEmpresa =
                                              value.nombre!;
                                          homeController.index = 0;
                                          Modular.to.pushNamed('/home');
                                        } else {
                                          homeController.index = 6;
                                          Modular.to
                                              .pushNamed('/configuracion/');
                                        }
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(FluentIcons.save),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("Guardar"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          const Text(
              "*Para poder utilizar el sistema, es necesario tener completados los campos de la empresa*"),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: 240,
            child: Button(
                style:
                    ButtonStyle(backgroundColor: ButtonState.all(Colors.white)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const TruncateDialog(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FluentIcons.clear_formatting_eraser,
                      color: Colors.red,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Reset base de datos",
                      style: FluentTheme.of(context)
                          .typography
                          .bodyStrong!
                          .copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                dataShared.version,
                style: FluentTheme.of(context).typography.subtitle,
              )
            ],
          )
        ],
      ),
    );
  }
}
