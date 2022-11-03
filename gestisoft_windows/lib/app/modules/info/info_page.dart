import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    final DataShared dataShared = Modular.get();
    return SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 800,
              maxHeight: 800,
            ),
            child: Acrylic(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      height: 400,
                      child: Transform.scale(
                        scale: .5,
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Titulo del proyecto: GESTISOFT",
                          style: FluentTheme.of(context)
                              .typography
                              .title!
                              .copyWith(
                                color: Colors.orange.dark,
                              ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Desarrolladores: ITALO GOLIN Y GUILLERMO CABALLERO",
                          style: FluentTheme.of(context).typography.subtitle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Analista: Alma Santacruz",
                          style: FluentTheme.of(context).typography.subtitle,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Descripcion: Es un proyecto analizado para cubrir las demandas de un modulo de ventas de una distribuidora de arena y piedras, tiene las funcionalidades de registrar clientes, productos, vendedores, y ventas. Tambien cuenta con reportes de cada uno de estos modulos registrados.",
                          style: FluentTheme.of(context).typography.body,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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
